Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263186AbTDBX0v>; Wed, 2 Apr 2003 18:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263187AbTDBX0v>; Wed, 2 Apr 2003 18:26:51 -0500
Received: from [131.215.233.56] ([131.215.233.56]:26122 "EHLO bryanr.org")
	by vger.kernel.org with ESMTP id <S263186AbTDBX0u>;
	Wed, 2 Apr 2003 18:26:50 -0500
Date: Wed, 2 Apr 2003 15:24:26 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: back-trace on mounting ide cd-rom
Message-ID: <20030402232426.GD14228@bryanr.org>
References: <1049326318.2872.36.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049326318.2872.36.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 06:31:59PM -0500, Robert Love wrote:
> I haven't looked into it yet.  Not sure why there is ext3 stuff in
> there... maybe the CD-ROM mount is unrelated?  Mounting the CD
> subsequent times is OK.

weak guess: maybe mount is trying to auto-probe the filesystem and the
ext3 code gets upset on cdrom. are you using -t iso9660?

-Bryan

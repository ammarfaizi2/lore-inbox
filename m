Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275573AbRIZUMm>; Wed, 26 Sep 2001 16:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275572AbRIZUMc>; Wed, 26 Sep 2001 16:12:32 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41207
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S275570AbRIZUML>; Wed, 26 Sep 2001 16:12:11 -0400
Date: Wed, 26 Sep 2001 13:12:32 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove ext2_notify_change()
Message-ID: <20010926131232.A28690@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SUN.3.96.1010926145958.8988A-100000@grex.cyberspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SUN.3.96.1010926145958.8988A-100000@grex.cyberspace.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 03:09:52PM -0400, KVK wrote:
> ext2_notify_change() is no longer used by anyone. I think it can be 
> safely removed. Patch against 2.4.10 follows.
> 

This isn't the code that samba uses to get the kernel to report when a
directory has changed is it?

If so, I think you should check to make sure that it won't break samba.

If I'm wrong, please ignore...

Mike

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265871AbUFOTCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbUFOTCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUFOTC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:02:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54954 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265871AbUFOTBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:01:47 -0400
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
References: <20040612011129.GD1967@flower.home.cesarb.net>
	<orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
	<20040614224006.GD1961@flower.home.cesarb.net>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 15 Jun 2004 16:01:23 -0300
In-Reply-To: <20040614224006.GD1961@flower.home.cesarb.net>
Message-ID: <orfz8wabng.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 14, 2004, Cesar Eduardo Barros <cesarb@nitnet.com.br> wrote:

> The atime was never intended as an auditing feature (if it were, utimes
> and related functions would be root only).

But utimes updates the inode modification time, so you can still tell
something happened to the file.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

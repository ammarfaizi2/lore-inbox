Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262988AbVALBiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbVALBiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbVALBiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:38:22 -0500
Received: from colin2.muc.de ([193.149.48.15]:25870 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262988AbVALBiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:38:11 -0500
Date: 12 Jan 2005 02:38:05 +0100
Date: Wed, 12 Jan 2005 02:38:05 +0100
From: Andi Kleen <ak@muc.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: node_online_map patch kills x86_64
Message-ID: <20050112013805.GA74675@muc.de>
References: <20050111151656.A24171@build.pdx.osdl.net> <m1d5wb4jni.fsf@muc.de> <20050111163025.T469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111163025.T469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 04:30:25PM -0800, Chris Wright wrote:
> kernel direct mapping tables upto ffff810100000000 @ 8000-d000
> PANIC: early exception rip ffffffff8078b2e3 error 0 cr2 17c498a67
>   Filesystem type ext2
>   (couple more grub messgages like kernel name, root device)

Can you please boot with earlyprintk=serial,ttyS0,baud and send the full
boot log? 

And also look up where ffffffff8078b2e3 is in System.map.


-Andi

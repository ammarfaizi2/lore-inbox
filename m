Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUCLOD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 09:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCLOD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 09:03:56 -0500
Received: from colin2.muc.de ([193.149.48.15]:20491 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262126AbUCLODy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 09:03:54 -0500
Date: 12 Mar 2004 15:03:52 +0100
Date: Fri, 12 Mar 2004 15:03:52 +0100
From: Andi Kleen <ak@muc.de>
To: Joe Thornber <thornber@redhat.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040312140352.GA80958@colin2.muc.de>
References: <1yyqt-83X-23@gated-at.bofh.it> <1yyqs-83X-17@gated-at.bofh.it> <1yyJK-8mD-41@gated-at.bofh.it> <1yzPs-1bI-21@gated-at.bofh.it> <1yGe9-7Rk-23@gated-at.bofh.it> <1yI6f-1Bj-3@gated-at.bofh.it> <1yQdz-1Uf-7@gated-at.bofh.it> <1yRCI-3lE-19@gated-at.bofh.it> <m3k71htm2l.fsf@averell.firstfloor.org> <20040312134943.GY18345@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312134943.GY18345@reti>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 01:49:43PM +0000, Joe Thornber wrote:
> On Fri, Mar 19, 2004 at 06:58:26AM +0100, Andi Kleen wrote:
> > That's bad because it will break binary compatibility for existing
> > x86-64 systems.  Don't add that please. Either emulate it properly
> > or I will just declare the 32bit DM emulation broken and users will
> > have to live with that.
> 
> So you want me to put in a seperate set of ioctl codes for
> compatibility.

Breaking the 64bit ABI is not acceptable at least. There are distributions
shipping that use it.

For 32bit emulation you can use what you think is easiest or just
ignore it if it's too hard (64bit is more important than 32bit)

-Andi

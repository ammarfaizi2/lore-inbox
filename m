Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136062AbRDVMSn>; Sun, 22 Apr 2001 08:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136063AbRDVMSk>; Sun, 22 Apr 2001 08:18:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136062AbRDVMSX>;
	Sun, 22 Apr 2001 08:18:23 -0400
Date: Sun, 22 Apr 2001 13:18:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
Message-ID: <20010422131803.C20807@flint.arm.linux.org.uk>
In-Reply-To: <20010421211722.C976@ulthar.internal.mclure.org> <E14rIiE-0005h2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14rIiE-0005h2-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 22, 2001 at 01:11:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2001 at 01:11:31PM +0100, Alan Cox wrote:
> This is from Linus tree. You currently need gcc 2.96 or higher to build
> the 2.4.x kernel. 

Which goes back to the old argument that 2.96 is a redhat-ism and not a
real compiler.

To date, no 2.96 version of gcc works properly on ARM, and I for one don't
have the expertise necessary to fix gcc myself.  Do you recommend that I
stop all ARM work because of this? ;(

Anyway, the work around is a trivial one that I've already posted to the
list, including the necessary GCC version tests.  Additionally David
Howells has posted a patch to remove the __builtin_expect stuff, so
this is a non-issue now.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


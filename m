Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267517AbRG2CxQ>; Sat, 28 Jul 2001 22:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRG2CxG>; Sat, 28 Jul 2001 22:53:06 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:48656 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S267517AbRG2Cw6>; Sat, 28 Jul 2001 22:52:58 -0400
Date: Sat, 28 Jul 2001 19:53:05 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: make rpm
Message-ID: <20010728195305.N30957@bluemug.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15QeJf-0008O8-00@the-village.bc.nu> <87g0bg7ded.fsf@pfaffben.user.msu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87g0bg7ded.fsf@pfaffben.user.msu.edu>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 09:05:46PM -0400, Ben Pfaff wrote:
> 
> Debian has had a package that does this for years now.  It's
> called `kernel-package' and works through a program called
> `make-kpkg' that does all sorts of nice things.  Using
> kernel-package, you could implement `make dpkg' as a single
> command: `make-kpkg kernel_image'.

I suggest '$(FAKEROOT) make-kpkg kernel_image'

miket

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292919AbSBVQBJ>; Fri, 22 Feb 2002 11:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292920AbSBVQBA>; Fri, 22 Feb 2002 11:01:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7430 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292919AbSBVQAv>;
	Fri, 22 Feb 2002 11:00:51 -0500
Message-ID: <3C766B31.6922270C@mandrakesoft.com>
Date: Fri, 22 Feb 2002 11:00:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Jes Sorensen <jes@trained-monkey.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Troy Benjegerdes <hozer@drgw.net>, wli@holomorphy.com,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bring sanity to div64.h and do_div usage
In-Reply-To: <5.1.0.14.2.20020208113710.04ecedf0@pop.cus.cam.ac.uk>
		<20020207234555.N17426@altus.drgw.net>
		<5.1.0.14.2.20020208181656.03862ec0@pop.cus.cam.ac.uk>
		<d37kp5v9y5.fsf@lxplus050.cern.ch>
		<3C7660F5.FC238A7E@mandrakesoft.com>
		<15478.25001.512565.628500@trained-monkey.org>
		<3C76631C.E685815D@mandrakesoft.com> <jepu2xzf26.fsf@sykes.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> If consistency is your goal then CONFIG_I386 should be defined.

I was referring to consistency of having one symbol that can be tested
in most (note: not all) makefiles, C code, and config.in code.

The i386 arch already has CONFIG_X86.  I agree that if someone cared to
make define always equal CONFIG_upcase($arch), you are correct.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |

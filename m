Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129310AbRBVXpO>; Thu, 22 Feb 2001 18:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129332AbRBVXpF>; Thu, 22 Feb 2001 18:45:05 -0500
Received: from ns2.cypress.com ([157.95.67.5]:40663 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S129323AbRBVXoz>;
	Thu, 22 Feb 2001 18:44:55 -0500
Message-ID: <3A95A46A.76C50741@cypress.com>
Date: Thu, 22 Feb 2001 17:44:42 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use correct include dir for build tools
In-Reply-To: <20010222123940.A20319@tenchi.datarithm.net> <E14W4EP-00055G-00@the-village.bc.nu> <20010222144055.B20752@tenchi.datarithm.net> <20010222150946.D20997@thune.yy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Castle wrote:
> (libc does usually take care to be able to build against a later kernel
> version than you're running on, and determine at run time what features may
> or may not be there, so one could have a 2.4.2 kernel handy to build libc
> against while still running a 2.2.18 kernel.  Theoretically.)

Red Hat did that for glibc-2.1.9 and glibc-2.2 in RHL-7.0.
Hundreds have complaind about /usr/include/linux
not being a sym link to /usr/src/linux/include/linux.
The kernel headers for glibc are form a pre 2.4.0 kernel
and should probably be updated along with a new glibc
built against the new headers.
I've had no problems with it so far, been running since the
pinstripe beta release.

	-Thomas

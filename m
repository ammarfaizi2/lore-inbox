Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277831AbRJIQzE>; Tue, 9 Oct 2001 12:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277840AbRJIQx7>; Tue, 9 Oct 2001 12:53:59 -0400
Received: from ns.suse.de ([213.95.15.193]:15122 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277832AbRJIQwu>;
	Tue, 9 Oct 2001 12:52:50 -0400
Date: Tue, 9 Oct 2001 18:53:19 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Thomas Hood <jdthood@mail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: sysctl interface to bootflags?
In-Reply-To: <1002643014.1103.42.camel@thanatos>
Message-ID: <Pine.LNX.4.30.0110091851200.11249-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2001, Thomas Hood wrote:

> jdthood@thanatos:~/src/sbf$ gcc -O2 sbf.c
> Segmentation fault

Ok, I managed to repeat this here. Fortunatly, the
pending fixes from Randy Dunlap include a fix for this.
Updated version at http://www.codemonkey.org.uk/cruft/
(including a version with the /dev/nvram using interface
which got dropped for reasons I don't recall).

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs


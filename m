Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbREWKDm>; Wed, 23 May 2001 06:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbREWKDc>; Wed, 23 May 2001 06:03:32 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:47879 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261374AbREWKDW>;
	Wed, 23 May 2001 06:03:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Olivier Galibert <galibert@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac14 
In-Reply-To: Your message of "Wed, 23 May 2001 05:36:20 -0400."
             <20010523053620.C7114@zalem.puupuu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 May 2001 20:03:14 +1000
Message-ID: <21475.990612194@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001 05:36:20 -0400, 
Olivier Galibert <galibert@pobox.com> wrote:
>On Wed, May 23, 2001 at 07:07:38PM +1000, Keith Owens wrote:
>> What is the point of including it in the kernel source tree without the
>> code to convert it to ser_a2232fw.h?  Nobody can use ser_a2232fw.ax, it
>> is just bloat.
>
>We don't provide the binutils or gcc with the kernel either.  The 6502
>is a rather well known processor.  Try plonking "6502 assembler" in
>google and you'll have a lot of choice.

I can accept that, but only if there is some documentation in
drivers/char/Makefile to tell people which 6502 assembler to use and
how it should be run, preferably including the commands used by the
maintainer to generate ser_a2232fw.h.  Comment out the commands to
prevent them being used by mistake (we don't want another aic7xxx
debacle) but it should be documented.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263036AbREWJh1>; Wed, 23 May 2001 05:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263040AbREWJhU>; Wed, 23 May 2001 05:37:20 -0400
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:33425 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S263036AbREWJgW>;
	Wed, 23 May 2001 05:36:22 -0400
Date: Wed, 23 May 2001 05:36:20 -0400
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac14
Message-ID: <20010523053620.C7114@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10105230915100.16280-100000@callisto.of.borg> <20677.990608858@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20677.990608858@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Wed, May 23, 2001 at 07:07:38PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 07:07:38PM +1000, Keith Owens wrote:
> On Wed, 23 May 2001 09:17:08 +0200 (CEST), 
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >On Wed, 23 May 2001, Keith Owens wrote:
> >> Is drivers/char/ser_a2232fw.ax supposed to be included?  Nothing uses it.
> >
> >It's the source for the firmware hexdump in ser_a2232fw.h, provided as a
> >reference.
> 
> What is the point of including it in the kernel source tree without the
> code to convert it to ser_a2232fw.h?  Nobody can use ser_a2232fw.ax, it
> is just bloat.

We don't provide the binutils or gcc with the kernel either.  The 6502
is a rather well known processor.  Try plonking "6502 assembler" in
google and you'll have a lot of choice.

Having the source with the .h helps doing this little thing called
debugging.

  OG, who hates acenic_firmware.h for that exact same reason.


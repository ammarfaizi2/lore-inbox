Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTATUhc>; Mon, 20 Jan 2003 15:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTATUhc>; Mon, 20 Jan 2003 15:37:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36881 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266840AbTATUhc>;
	Mon, 20 Jan 2003 15:37:32 -0500
Date: Mon, 20 Jan 2003 21:46:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
Message-ID: <20030120204633.GA1886@mars.ravnborg.org>
Mail-Followup-To: Olaf Titz <olaf@bigred.inka.de>,
	linux-kernel@vger.kernel.org
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <20030119001256.GA11575@compsoc.man.ac.uk> <E18aEyl-0006O0-00@bigred.inka.de> <20030119182250.GA1495@mars.ravnborg.org> <E18aiJF-000344-00@bigred.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18aiJF-000344-00@bigred.inka.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 09:14:17PM +0100, Olaf Titz wrote:
> first the kernel:
> 
> /usr/src/linux/2.5.99/              this is directory X
> /var/obj/linux/2.5.99/boxa          here is X compiled for boxa
> /var/obj/linux/2.5.99/boxb          here is X compiled for boxb
> 
> (this doesn't work either at the moment, another bug/missing feature...)

Call it a missing feature, I have posted patches for this before.
Small details missing to enable it.

> then the external module:
> 
> /usr/src/cipe                       this is directory Y
> /var/obj/cipe/2.5.99/boxa           here is Y compiled against X for boxa
> /var/obj/cipe/2.5.99/boxb           here is Y compiled against X for boxb
> 
> and /usr/src might be mounted read-only.

If I remember when I return to the "separate src tree" patch, I will
enable this as well.
I have not thought about this before, thanks for input.

	Sam

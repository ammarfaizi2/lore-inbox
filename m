Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312208AbSCYCJB>; Sun, 24 Mar 2002 21:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312233AbSCYCIu>; Sun, 24 Mar 2002 21:08:50 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31501 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S312208AbSCYCIi>; Sun, 24 Mar 2002 21:08:38 -0500
Date: Mon, 25 Mar 2002 03:08:33 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Cc: becker@scyld.com, jonathan@woaf.net
Subject: Re: Possible problems with D-LINK DFE-550TX (stock sundance driver) under 2.4.18
Message-ID: <20020325020833.GE1566@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, becker@scyld.com,
	jonathan@woaf.net
In-Reply-To: <20020325004808.GA7838@woaf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, David Flynn wrote:

> With the following hardware::
>   dual Athlon XP 1700+
>   D-Link DFE-550TX NIC
>   SiS cheapo g/card

El cheapo configuration, Athlon XP are not stable in SMP configurations.

(I look after a dual XP 1700+ machine with Tyan board, and it falls over
from time to time, but booted with just one CPU, the machine is rock
solid.)

Try booting with just one processor (maxcpus=1 boot option) or borrow
two Athlon MP and see if you can reproduce the problem then. If you can,
someone may help you. I you can't reproduce it with one CPU, you're
probably on your own.

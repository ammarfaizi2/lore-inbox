Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTEaK3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTEaK3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:29:23 -0400
Received: from imsantv21.netvigator.com ([210.87.250.77]:33986 "EHLO
	imsantv21.netvigator.com") by vger.kernel.org with ESMTP
	id S264266AbTEaK3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:29:22 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: =?iso-8859-1?q?=C9ric=20Brunet?= <Eric.Brunet@lps.ens.fr>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70 freezes when running hwclock
Date: Sat, 31 May 2003 18:41:47 +0800
User-Agent: KMail/1.5.2
References: <20030531080544.GA13848@lps.ens.fr>
In-Reply-To: <20030531080544.GA13848@lps.ens.fr>
X-OS: GNU/Linux 2.4.21-pre5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305311841.47238.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 16:05, Éric Brunet wrote:
> I have tried 2.5.70 on an intel chipset based pc, and I
> got a reproductible complete freeze during the boot
> process when hwclock is run. Even Caps Lock wouldn't lit
> the little led.
>
> Removing the offending line, 2.5.70 seemed to work... I
> haven't fully tried it yet.
>
> Is this problem known/identified/fixed yet, or do you
> want a more complete bug report ?

This seems to be an ACPI related problem on ALI 1533/1535 
compatible implementations frequently seen on Toshiba's.

As a workaround, Boot with ACPI=off and add --directisa to 
hwclock lines in rc.sysinit and halt (or their equivalents)

If this is really an Intel chipset it would be a first 

Please post your problem, solution and system info and lspci 
to ACPI list.

Regards
Michael


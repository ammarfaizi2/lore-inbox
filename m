Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbTCHWWU>; Sat, 8 Mar 2003 17:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262272AbTCHWWU>; Sat, 8 Mar 2003 17:22:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52230 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262260AbTCHWWT>; Sat, 8 Mar 2003 17:22:19 -0500
Date: Sat, 8 Mar 2003 17:28:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Harald.Schaefer@gls-germany.com
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas.Mieslinger@gls-germany.com,
       linux-kernel@vger.kernel.org
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
In-Reply-To: <OFA9D69D12.A2BE6A15-ONC1256CE1.00344A6F-C1256CE1.0039609A@LocalDomain>
Message-ID: <Pine.LNX.3.96.1030308172559.4525D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003 Harald.Schaefer@gls-germany.com wrote:

>  *    1. CHS value set by user       (whatever user sets will be trusted)
>  *    2. LBA value from target drive (require new ATA feature)
>  *    3. LBA value from system BIOS  (new one is OK, old one may break)
>  *    4. CHS value from system BIOS  (traditional style)
> 
> I think that the priority of LBA from BIOS has to be raised to 2 and the
> priority of LBA from drive should be lowered to 3.
> The mapping-problem only appreared with very new drives in some
> brand-computers using a 240-head mapping from the bios.

I think the chances of a drive knowing its own correct LBA info is far
better than the BIOS getting it right. Many BIOS versions don't understand
large drives.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


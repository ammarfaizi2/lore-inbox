Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131129AbQLMLt0>; Wed, 13 Dec 2000 06:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131190AbQLMLtQ>; Wed, 13 Dec 2000 06:49:16 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:9361 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S131129AbQLMLtH>; Wed, 13 Dec 2000 06:49:07 -0500
Date: Wed, 13 Dec 2000 12:18:33 +0100 (CET)
From: Nils Philippsen <nils@fht-esslingen.de>
Reply-To: <nils@fht-esslingen.de>
To: Paul Jakma <paul@clubi.ie>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio - bad latency 
In-Reply-To: <Pine.LNX.4.30.0012130244140.1326-100000@fogarty.jakma.org>
Message-ID: <Pine.LNX.4.30.0012131200050.28736-100000@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Paul Jakma wrote:

> hi,
>
> i think somethings gone wrong with via82cxxx_audio. Playing anything
> through it seems to cause massive latency in apps like xmms, esd,
> asmixer, etc.. anything to do with playing or mixer levels suddenly
> takes a minute or more to respond.

Same here. Kernel is test12-pre8 and board is an Epox 8KTA2 (VIA KT133
chipset). The funny thing is that audio itself doesnt get blocked, just XMMS'
GUI.

> the via is sharing an interrupt, though normally the buslogic is not
> being used. (the interrupt sharing has been there a lot longer than
> this problem)
>
> i don't have the /proc/driver/via.... files that the docs mention.

I will take a look into this when I'm at home (at the offending machine).

Nils
-- 
 Nils Philippsen / Berliner Straﬂe 39 / D-71229 Leonberg // +49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@fht-esslingen.de / nils@redhat.de
   The use of COBOL cripples the mind; its teaching should, therefore, be
   regarded as a criminal offence.                  -- Edsger W. Dijkstra

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

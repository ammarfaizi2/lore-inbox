Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136256AbRDVSkR>; Sun, 22 Apr 2001 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135243AbRDVSj6>; Sun, 22 Apr 2001 14:39:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65040 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135242AbRDVSjr>; Sun, 22 Apr 2001 14:39:47 -0400
Subject: Re: Inspiron 8000 does not resume after suspend
To: jes@linuxcare.com (Jes Sorensen)
Date: Sun, 22 Apr 2001 19:41:05 +0100 (BST)
Cc: woodst@cs.tu-berlin.de (Daniel Dorau), linux-kernel@vger.kernel.org
In-Reply-To: <d3elul0vuv.fsf@lxplus015.cern.ch> from "Jes Sorensen" at Apr 22, 2001 05:58:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rOnD-0006KS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This sounds a little like the problem I am seeing with my
> StinkPad 600E, you might want to try enabling CONFIG_APM_ALLOW_INTS
> and see if that makes a difference (thats the magic option required
> for the 600E).

If you have machines which have requirements for specific APM settings please
run dmidecode 1.1 or later on them (ftp.linux.org.uk/pub/linux/alan/DMI/...)
and give me the options you needed as well as the DMI output. I can then 
extend the DMI blacklists in -ac to automatically set these things.

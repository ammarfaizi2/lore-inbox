Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSBCA1v>; Sat, 2 Feb 2002 19:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSBCA1k>; Sat, 2 Feb 2002 19:27:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36869 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284732AbSBCA1W>; Sat, 2 Feb 2002 19:27:22 -0500
Subject: Re: SIOCDEVICE ?
To: romieu@cogenit.fr (Francois Romieu)
Date: Sun, 3 Feb 2002 00:40:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020202231848.A5644@fafner.intra.cogenit.fr> from "Francois Romieu" at Feb 02, 2002 11:18:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XAho-0000z6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> done with IF_PROTO_FR_{ADD/DEL}_PVC.
> 
> (1) Let's forget pppsync and it's revolting games with net_device.priv for now.

The syncppp code needs to be switched to use the generic ppp layer anyway.
It was very much a "we need it now" solution as 2.2 lacked generic ppp

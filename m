Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSJCMCw>; Thu, 3 Oct 2002 08:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJCMCv>; Thu, 3 Oct 2002 08:02:51 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:5104 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261263AbSJCMCv>; Thu, 3 Oct 2002 08:02:51 -0400
Subject: Re: Sequence of IP fragment packets on the wire
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <anh7es$mpl$1@forge.intermeta.de>
References: <anh7es$mpl$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 13:16:10 +0100
Message-Id: <1033647370.28022.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 11:51, Henning P. Schmiedehausen wrote:
> This confuses at least one firewall appliance. As I understand it,

You should replace that appliance. Packets can get re-ordered by a
million different things on the wire not just by the fact Linux is
optimising the fragment processes.

> Is there a way to configure this? Maybe even connection specific? 

No

Alan


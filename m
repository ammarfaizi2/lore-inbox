Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRKMQqN>; Tue, 13 Nov 2001 11:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276364AbRKMQpz>; Tue, 13 Nov 2001 11:45:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32522 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276344AbRKMQpc>; Tue, 13 Nov 2001 11:45:32 -0500
Subject: Re: via82cxxx_audio problems
To: tori@ringstrom.mine.nu (Tobias Ringstrom)
Date: Tue, 13 Nov 2001 16:53:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@datacom-telematica.com.br (Marcelo Borges Ribeiro),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111131441100.1452-100000@boris.prodako.se> from "Tobias Ringstrom" at Nov 13, 2001 02:50:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163go2-0001et-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only if you use the OSS module for output.  Using esound (which is the
> default in RH 7.2) it sounds terrible.  That might be esound's fault 
> though.

Thats a problem with esound - its rate adaption code is not very bright and
it doesnt let the caller know the preferred data rate. Arts is somewhat
better


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291271AbSBMAX4>; Tue, 12 Feb 2002 19:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291273AbSBMAXr>; Tue, 12 Feb 2002 19:23:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18195 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291271AbSBMAXb>; Tue, 12 Feb 2002 19:23:31 -0500
Subject: Re: [patch] sys_sync livelock fix
To: riel@conectiva.com.br (Rik van Riel)
Date: Wed, 13 Feb 2002 00:36:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.33L.0202122215020.12554-100000@imladris.surriel.com> from "Rik van Riel" at Feb 12, 2002 10:15:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16anPg-0003cy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see why it should be different for applications
> that write data after sync has started.

The guarantee about data written _before_ the sync started is also being
broken unless I misread the code


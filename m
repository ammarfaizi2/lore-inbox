Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRCWJaU>; Fri, 23 Mar 2001 04:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130433AbRCWJaK>; Fri, 23 Mar 2001 04:30:10 -0500
Received: from [212.115.175.146] ([212.115.175.146]:1781 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S130388AbRCWJaF>; Fri, 23 Mar 2001 04:30:05 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F107E@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Rik van Riel <riel@conectiva.com.br>, Tom Kondilis <tomk@plaza.ds.adp.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Prevent OOM from killing init
Date: Fri, 23 Mar 2001 10:28:50 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not the OOM killer however, but init dying because it
> couldn't get the memory it needed to satisfy a page fault or
> somesuch...

Ehrm, I would like to re-state that it still would be nice if
some mechanism got introduced which enables one to set certain
processes to "cannot be killed".
For example: I would hate it it the UPS monitoring daemon got
killed for obvious reasons :o)

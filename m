Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263810AbRFDGmu>; Mon, 4 Jun 2001 02:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264120AbRFDGmk>; Mon, 4 Jun 2001 02:42:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31240 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263810AbRFDGmd>; Mon, 4 Jun 2001 02:42:33 -0400
Subject: Re: [PATCH] Remove nr_async_pages limit
To: zlatko.calusic@iskon.hr
Date: Mon, 4 Jun 2001 07:39:10 +0100 (BST)
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <874rtxoidx.fsf@atlas.iskon.hr> from "Zlatko Calusic" at Jun 03, 2001 02:30:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156o18-00059a-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch removes the limit on the number of async pages in the
> flight.

I have this in all  2.4.5-ac. It does help a little but there are some other
bits you have to deal with too, in paticular wrong aging. See the -ac version

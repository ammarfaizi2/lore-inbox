Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUAEQlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUAEQlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:41:09 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:8621 "EHLO dns.toxicfilms.tv")
	by vger.kernel.org with ESMTP id S263609AbUAEQlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:41:07 -0500
Message-ID: <010201c3d3aa$bbdf9900$0e25fe0a@southpark.ae.poznan.pl>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <1073320318.21198.2.camel@midux>
Subject: [patchlet link] Re: 2.6.1-rc1 affected?
Date: Mon, 5 Jan 2004 17:41:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it seems as though in the report:
http://isec.pl/vulnerabilities/isec-0013-mremap.txt

And from the looks of mm/mremap.c

For those who might be in need to update mm/mremap.c I extracted the
patch from 2.4.24 and tested on 2.6.0.
You might just patch 2.6.0 with the exact same patch which
is in 2.6.

http://dns.toxicfilms.tv/mremap.diff

But does grsec for 2.4 guard against this? I doubt it, but I am no guru.
Does anyone knowledgeble enough have an answer?

Regards,
Maciej


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUF1OZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUF1OZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUF1OZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:25:30 -0400
Received: from smtpde02.sap-ag.de ([155.56.68.170]:37525 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP id S264960AbUF1OZ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:25:28 -0400
From: "Christoph Rohland" <cr@sap.com>
To: "'Stas Sergeev'" <stsp@aknet.ru>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch][rfc] expandable anonymous shared mappings
Date: Mon, 28 Jun 2004 16:25:19 +0200
Message-ID: <AC444F6A32413E438EAD09097B39E3DE7B4D10@dewdfe10.wdf.sap.corp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <40D9CFAC.9040609@aknet.ru>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stas,

> But no, my prog won't die without the expandable
> anon shared mapping thing. I can resort to the other
> matters. I can (as I do right now) to just open a
> tmp file in /dev/shm and use the custom allocator.

BTW that's what librt does: look into /dev/shm scheck if it is tmpfs and do
an open...

> Yes, that works, but I wanted to keep it "simple
> and stupid". The anon shared mapping looked like
> the good candidate to try out.

Yes, I understand. For your use case anon shared mem with the small addition
is perfect.

> And then I thought it may be nice if the kernel
> to provide this functionality. 

For me the question is: The functionality you propose is very specific for
your problem. The kernel should provide general solutions. So is there a
bigger demand for this?

Greetings
                  Christoph


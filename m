Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVC1VJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVC1VJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 16:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVC1VJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 16:09:18 -0500
Received: from smtp05.auna.com ([62.81.186.15]:49033 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S262082AbVC1VJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 16:09:15 -0500
From: "Fabio Valpondi" <fvalpondi@salleurl.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Override 802.11 MAC functions in Linux Kernel
Date: Mon, 28 Mar 2005 23:08:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUz2lWbXwmKuXC+RzuDprkncIJLSw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Message-Id: <20050328210908.IMON1111.smtp05.retemail.es@LupoLaptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to implement the EDCF described in new standard 802.11e (This
standard -well, actually it's a draft- tries to define QoS for 802.11
networks).
I would like to implement it with a module over the 2.6.11.5 kernel.
My idea is to override the regular 802.11 MAC operation and redirect it to
the module so that I can treat it like 802.11e MAC specifies.
I have browsed a lot of pages, but none of them explains how to override the
functions. Do you know how can I redirect all the functions to the modules?
Is it possible to do it with a module? Or maybe should I work directly over
the kernel code?
If I had to work over the kernel code, which are the files directly involved
with the 802.11 MAC?

Thank you very much!

Fabio Valpondi
fvalpondi@salleurl.edu
Ingenieria La Salle - Barcelona (Spain)




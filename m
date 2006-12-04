Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935193AbWLDRtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935193AbWLDRtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935692AbWLDRtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:49:50 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:48508 "EHLO
	ms-smtp-02.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935370AbWLDRtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:49:49 -0500
Message-Id: <200612041749.kB4HnDNw008901@ms-smtp-02.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>
Cc: "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Mon, 4 Dec 2006 11:49:12 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <200612041707.kB4H7Mnh020665@laptop13.inf.utfsm.cl>
Thread-Index: AccXxspmT1QytNmCTC+FwveSYc008wABO6zg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Horst H. von Brand [mailto:vonbrand@inf.utfsm.cl]
> That means that there isn't a need for that memory at all (and so they

In the current isolated non-production, not actually bearing a load test
case yes. But if I can't get it to not swap on an idle system I have no hope
of avoiding OOM on a loaded system.

> In any case, how do you know it is the tar data that stays around, and not
> just that the number of pages "in use" stays roughly constant?

I'm not dumping the contents of memory so I don't.

> - What you are doing, step by step

Trying to deliver a high availability, linearly scalable, clustered iSCSI
storage solution that can be upgraded with minimum downtime.

> - What are your exact requirements

OOM not to kill anything.

> - In what exact way is it missbehaving. Please tell /in detail/ how you

OOM kills important stuff.



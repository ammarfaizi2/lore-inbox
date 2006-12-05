Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937392AbWLEGlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937392AbWLEGlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937386AbWLEGlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:41:24 -0500
Received: from ms-smtp-06.texas.rr.com ([24.93.47.45]:51489 "EHLO
	ms-smtp-06.texas.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937362AbWLEGlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:41:21 -0500
Message-Id: <200612050641.kB56f7wY018196@ms-smtp-06.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Tue, 5 Dec 2006 00:41:07 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <Pine.LNX.4.64.0612042034060.3542@woody.osdl.org>
Thread-Index: AccYKFlX15XVnIOPRHW+SUz5aoLFAQADyh3w
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linus Torvalds [mailto:torvalds@osdl.org]
> I actually suspect you should be _fairly_ close to such a situation

We run with min_free_kbytes set around 4k to answer your earlier question.

> Louis, exactly how do you allocate that big 1.6GB shared area?

Ummm, shm_open, ftruncate, mmap ? Is it a trick question ? The process
responsible for initially setting up the shared area doesn't stay resident.



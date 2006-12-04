Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936910AbWLDOjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936910AbWLDOjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936912AbWLDOjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:39:33 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:52123 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S936910AbWLDOjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:39:32 -0500
Message-Id: <200612041439.kB4EdGFn025092@ms-smtp-03.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Kyle Moffett'" <mrmacman_g4@mac.com>
Cc: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Mon, 4 Dec 2006 08:39:24 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AccXdPeJFh+BZdCTTDeLGzOtx8jOWQAO6B8A
In-Reply-To: <5E2B4840-C384-48E2-A5C2-ED3C84FA7A48@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > PS: No need to put a copy of the entire message

Apologies for the lapse in protocol.

> The point you're missing is that an "inactive" page is a free 
> page that happens to have known clean data on it 

I understand now where the inactive page count is coming from.
I don't understand why there is no way for me to make the kernel
prefer to reclaim inactive pages before choosing swap.

> In this case you're telling the kernel to go beyond its 
> normal housekeeping and delete perfectly good data from 
> memory.  The only reason to do that is usually to make 

The definition of perfectly good here may be up for debate or
someone can explain it to me. This perfectly good data was
cached under the tar yet hours after the tar has completed the
pages are still cached.



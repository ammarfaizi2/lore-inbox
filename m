Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265548AbUEZM17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUEZM17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUEZM17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:27:59 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:17802 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265548AbUEZM1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:27:50 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'John Bradford'" <john@grabjohn.com>,
       "'Anthony DiSante'" <orders@nodivisions.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 05:31:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200405260906.i4Q96wgx000663@81-2-122-30.bradfords.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDAFbjX0F1X6e2TaW46zFnYrF8HgAHEI+w
Message-Id: <S265548AbUEZM1u/20040526122750Z+516@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In my experience, it's perfectly possible to run a typical desktop system
> with no swap at all.  Certainly the 'double the amount of physical RAM' 
> guideline has been taken far too literally in my opinion.

--------snip---------

In older BSD systems like SunOS 4.x, malloc would literally fail if you did
not have enough physical memory and backing store (swap) to store that
anonymous memory segment. 

This meant that if you wanted to leverage swap to get additional virtual
memory beyond the amount of installed physical memory, you needed more than
1x physical memory. This is where the old 2x physical memory came from.

--Buddy


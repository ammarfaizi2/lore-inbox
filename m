Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTATTkw>; Mon, 20 Jan 2003 14:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbTATTkX>; Mon, 20 Jan 2003 14:40:23 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:128 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S266795AbTATTi5>; Mon, 20 Jan 2003 14:38:57 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>,
       "'Jean-Eric Cuendet'" <jean-eric.cuendet@linkvest.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Disabling file system caching 
Date: Mon, 20 Jan 2003 20:47:52 +0100
Message-ID: <004001c2c0bc$d1e69750$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.50L.0301192303130.18171-100000@imladris.surriel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it possible to disable file caching for a given partition or mount?
> No, if you do that mmap(), read(), write() etc. would be impossible.

Hmmm, maybe there's some way to explicitly flush the read/write-cache?
Ok, sync will do nice for the write-cache, but for the read-one?



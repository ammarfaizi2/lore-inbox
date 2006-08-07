Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWHGSIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWHGSIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWHGSIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:08:10 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:46531 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932264AbWHGSIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:08:07 -0400
Date: Mon, 7 Aug 2006 20:06:25 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] UTF-8 input: composing non-latin1 characters, and
 copy-paste
In-Reply-To: <1154953118.25998.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0608072003460.3365@yvahk01.tjqt.qr>
References: <44D71C25.6090301@ums.usu.ru> <1154953118.25998.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-136917954-1154973985=:3365"
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-136917954-1154973985=:3365
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>
>> argument. This means that only characters present in Latin-1 (i.e., with 
>> codes <256) can be produced by composing while the keyboard is in 
>> Unicode mode. This is certainly unacceptable for Eastern Europe (i.e., 
>> former ISO-8859-2 users) who need to get ^+ Z = Ž.
>
>Its not useful for most of Western europe either nowdays.

As far as I can follow...

I don't think so. I have set my keyboard to US, but I regularly require 
<Compose><"><a> and such to generate Umlauts and Eszet. Now, ä is present 
in ISO-8859-1/15, but what if it were not?


Jan Engelhardt
-- 
--1283855629-136917954-1154973985=:3365--

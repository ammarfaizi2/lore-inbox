Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWH1LBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWH1LBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 07:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWH1LBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 07:01:06 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:13457 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964803AbWH1LBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 07:01:04 -0400
Date: Mon, 28 Aug 2006 12:58:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Richard Knutsson <ricknu-0@student.ltu.se>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
In-Reply-To: <20060828093202.GC8980@infradead.org>
Message-ID: <Pine.LNX.4.61.0608281255100.14305@yvahk01.tjqt.qr>
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Just would like to ask if you want patches for:
>
>Total NACK to any of this boolean ididocy.  I very much hope you didn't
>get the impression you actually have a chance to get this merged.
>
>> * (Most importent, may introduce bugs if left alone)
>> Fixing boolean checking, ex:
>> if (bool == FALSE)
>> to
>> if (!bool)
>
>this one of course makes sense, but please do it without introducing
>any boolean type.  Getting rid of all the TRUE/FALSE defines and converting
>all scsi drivers to classic C integer as boolean semantics would be
>very welcome janitorial work.

I don't get it. You object to the 'idiocy' 
(http://lkml.org/lkml/2006/7/27/281), but find the x==FALSE -> !x 
a good thing?


Jan Engelhardt
-- 

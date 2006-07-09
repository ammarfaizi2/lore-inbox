Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWGIWaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWGIWaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWGIWaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:30:14 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:62643 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1161200AbWGIWaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:30:13 -0400
Reveived: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id D45564AD65;
	Mon, 10 Jul 2006 00:30:11 +0200 (CEST)
Date: Mon, 10 Jul 2006 00:30:11 +0200
Message-Id: <793840896@web.de>
MIME-Version: 1.0
From: Arne Ahrend <aahrend@web.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, marcel@holtmann.org,
       maxk@qualcomm.com, mingo@elte.hu
Subject: Re: INFO: inconsistent lock state
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 12:28 +0200, Arjan van de Ven wrote:
> I think this is a real bug, well in fact there seem to be 2:
>
> there are 2 locks that have dodgy locking, one is a spinlock one is a
> rwlock. Both are used in softirq context, but neither had the proper _bh
> marking. The patch below corrects this

The patch has been working very well so far, and the informational error message has
not resurfaced over a couple of restarts.

Many thanks!


Arne

______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193


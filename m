Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTH1KKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263883AbTH1KH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:29 -0400
Received: from www.erfrakon.de ([193.197.159.57]:15621 "EHLO www.erfrakon.de")
	by vger.kernel.org with ESMTP id S263933AbTH1JUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:20:03 -0400
From: Martin Konold <martin.konold@erfrakon.de>
Organization: erfrakon
To: Timo Sirainen <tss@iki.fi>, Jamie Lokier <jamie@shareable.org>
Subject: Re: Lockless file reading
Date: Thu, 28 Aug 2003 11:13:59 +0200
User-Agent: KMail/kroupware-1.0.0
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
In-Reply-To: <3217CEE6-D906-11D7-A165-000393CC2E90@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281113.59112.martin.konold@erfrakon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 28 August 2003 05:17 am schrieb Timo Sirainen:

Hi Timo,

> How about checksum[n] = data[n-1] ^ data[n]? That looks like it would

I propose you first make some benchmarks and try to figure out how big the 
actual overhead of locking really is. I can easily assume that your 
"solution" is actually slower than a simple mechanism/semaphore. 

Regards,
-- martin

Dipl.-Phys. Martin Konold
e r f r a k o n
Erlewein, Frank, Konold & Partner - Beratende Ingenieure und Physiker
Nobelstrasse 15, 70569 Stuttgart, Germany
fon: 0711 67400963, fax: 0711 67400959
email: martin.konold@erfrakon.de


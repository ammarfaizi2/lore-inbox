Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTH0Msv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTH0Msv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:48:51 -0400
Received: from www.erfrakon.de ([193.197.159.57]:48903 "EHLO www.erfrakon.de")
	by vger.kernel.org with ESMTP id S263388AbTH0Msu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:48:50 -0400
From: Martin Konold <martin.konold@erfrakon.de>
Organization: erfrakon
To: Timo Sirainen <tss@iki.fi>
Subject: Re: Lockless file reading
Date: Wed, 27 Aug 2003 14:42:48 +0200
User-Agent: KMail/kroupware-1.0.0
References: <1061987837.1455.107.camel@hurina>
In-Reply-To: <1061987837.1455.107.camel@hurina>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271442.48672.martin.konold@erfrakon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 27 August 2003 02:37 pm schrieb Timo Sirainen:

Hi,

> The question is what can happen if I read() a file that's being
> simultaneously updated by a write() in another process?

The behaviour is undefined.
 
> 123 over XXX, is it possible that read() returns 1X3 in some conditions?

Yes. The actual order stuff is written to the disk is not guaranteed.

Regards,
-- martin

Dipl.-Phys. Martin Konold
e r f r a k o n
Erlewein, Frank, Konold & Partner - Beratende Ingenieure und Physiker
Nobelstrasse 15, 70569 Stuttgart, Germany
fon: 0711 67400963, fax: 0711 67400959
email: martin.konold@erfrakon.de


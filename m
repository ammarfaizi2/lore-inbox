Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTJVMcr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 08:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbTJVMcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 08:32:47 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:54190 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263591AbTJVMco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 08:32:44 -0400
Message-ID: <3F96793F.7020305@t-online.de>
Date: Wed, 22 Oct 2003 14:34:07 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031011
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: VIA IDE performance under 2.6.0-test7/8?
References: <C0D45ABB3F45D5118BBC00508BC292DB016038F5@imgserv04> <3F957DAC.6080901@superbug.demon.co.uk> <3F9669BF.1040408@t-online.de>
In-Reply-To: <3F9669BF.1040408@t-online.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Seen: false
X-ID: ZBRlC-ZFZePWTadPQX753kLvK3KdqPGhJnacjqUP24imo0re7SO6Ej@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem solved ...

I wrote that playing around with read ahead settings (hdparm -a ...) did 
not help.
In fact I was wrong, I assumed that these had identical meaning in the 
2.4 and
2.6 kernel series and tried nothing higher than 255 (2.4.x maximum). 
With 255
kernel 2.4.0 performed 50% better than 2.6.0.

After hdparm -a 8192 /dev/hd?: 2.6.0 performs 10% better than 2.4.0

Shouln´t the default settings be corrected?

cu,
Knut Petersen


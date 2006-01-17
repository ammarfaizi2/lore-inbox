Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWAQRsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWAQRsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWAQRsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:48:36 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:24449 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S932244AbWAQRsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:48:36 -0500
Date: Tue, 17 Jan 2006 18:48:32 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <Pine.LNX.4.64.0601162031220.2501@p34>
Message-ID: <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
References: <Pine.LNX.4.64.0601161957300.16829@p34> <20060117012319.GA22161@linuxace.com>
 <Pine.LNX.4.64.0601162031220.2501@p34>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-393772069-1137520112=:15077"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-393772069-1137520112=:15077
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 16 Jan 2006, Justin Piszcz wrote:

> Also, some people mentioned tuning, I used 8192 as the w/r size it then took 
> 15 seconds, with 65535 it took 28 seconds.
>
> I wonder how much faster NFS over TCP would be, or if NFS in the kernel is 
> the problem itself?

On Linux NFS over TCP is slower than over UDP ~10%.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-393772069-1137520112=:15077--

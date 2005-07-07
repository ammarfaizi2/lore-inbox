Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVGGQRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVGGQRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 12:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVGGQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 12:17:32 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:35019 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261330AbVGGQR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 12:17:28 -0400
Message-ID: <42CD5596.5040907@free.fr>
Date: Thu, 07 Jul 2005 18:17:26 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: Jeremy Laine <jeremy.laine@polytechnique.org>,
       linux-kernel@vger.kernel.org
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
References: <1120644686.42cbae4e16ea3@webmail.jerryweb.org>	<200507061859.40565.adobriyan@gmail.com>	<1120724705.42cce6e1e33c3@webmail.jerryweb.org> <42CD4667.9050205@brturbo.com.br>
In-Reply-To: <42CD4667.9050205@brturbo.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mauro Carvalho Chehab wrote:
> Jeremy,
> 
> 	BTTV cards uses massive data transfer via DMA when you are watching TV,
> transfering one screen every 1/30 s. Maybe you are suffering from a
> trouble on your motherboard or at board physical connection.
> 
I had (have ?) similar problem with a bt878 :
if I use bttv orverlay and do disk IO (a `grep toto /usr' for example), 
there quickly RISC corruption message and my log and also ext3 
corruption (that's why except for recovering epg data, I don't use 
anymore my card).
There were a similar report were someone and mozilla corruption when 
watching tv.


When using gradisplay, I don't saw faillure, but I don't try for a long 
time.

Jeremy do you use overlay or gradisplay ?

Matthieu

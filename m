Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270534AbTGUQoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270543AbTGUQon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:44:43 -0400
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:32651 "EHLO
	nx5.hrz.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S270526AbTGUQol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:44:41 -0400
Message-ID: <3F1C1BED.6010400@mathematik.uni-dortmund.de>
Date: Mon, 21 Jul 2003 18:59:25 +0200
From: Michael Abshoff <Michael.Abshoff@mathematik.uni-dortmund.de>
Reply-To: Michael.Abshoff@mathematik.uni-dortmund.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw
MIME-Version: 1.0
To: Viaris <bmeneses_beltran@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with kernel 2.5.75 (Urgent)
References: <Law11-OE21KRfcjcMzf0000fbd6@hotmail.com>
In-Reply-To: <Law11-OE21KRfcjcMzf0000fbd6@hotmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viaris wrote:
> Hi all,
> 
> I compiled kernel version 2.5.75, before I had kernel 2.4.20, the problem is
> that I need to enable SCSI DC395x, but when I execute lsmod I not found
> neither modules loaded, only appear:
> Module                  Size  Used by
> 
> If I mount manually a module (insmod
> /lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko) the following message
> appear: Error inserting
> '/lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko': -1 Unknown symbol in
> module, I have my modules.conf in the directory /lib/modules/2.5.75/ but
> this kernel no load automatically the modules.
> 
> I need to load this module because Ineed to use the tape backup, I have a
> backu that I need urgent.
> 
> How can I do it?
> 
> Thanks,
> -

Hello,

there is a patch for dc395 for the 2.4 kernel at

http://www.garloff.de/kurt/linux/dc395/

I last used it with 2.4.1[89] and it applied with offsets except
for the credits file which you shouldn't care about.

Hope this helps,

Michael


-- 
Michael Abshoff - MRB - Universität Dortmund - Telefon 755-3463 (intern)

    Where do you want to RTFM today?



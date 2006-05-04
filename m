Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWEDTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWEDTzE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 15:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWEDTzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 15:55:04 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:48570 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030312AbWEDTzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 15:55:03 -0400
Message-ID: <445A5BD5.2050508@ru.mvista.com>
Date: Thu, 04 May 2006 23:53:57 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Johan Palmqvist <johan.palmqvist@inap.se>
CC: mlaks@verizon.net, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: hpt366 driver oops or panic with HighPoint RocketRAID 1520	SATA
 (HPT372N)
References: <436FB350.6020309@inap.se> <1131467876.25192.51.camel@localhost.localdomain>
In-Reply-To: <1131467876.25192.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>When used with a HighPoint RocketRAID 1520 SATA (HPT372N) the hpt366 
>>driver, compiled as a module, oops'es on loading. If the driver is 
>>compiled into the kernel it causes a kernel panic on boot while 
>>detecting the card. Kernels tested: 2.6.13.2, 2.6.13.4 and 2.6.14. 
>>Please CC any answers to me since I'm not on the list.

    I think I've dealt with this oops now, see my recent patches to this
driver, particularly the one that reads the f_CNT value saved by BIOS...

WBR, Sergei


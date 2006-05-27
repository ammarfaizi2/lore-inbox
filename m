Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWE0XCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWE0XCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWE0XCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 19:02:07 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:35050 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S964967AbWE0XCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 19:02:06 -0400
Message-ID: <4478DA36.90408@ru.mvista.com>
Date: Sun, 28 May 2006 03:01:10 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPT3xx: switch to using pci_find_slot()
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478D889.506@gmail.com>
In-Reply-To: <4478D889.506@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jiri Slaby wrote:
> Sergei Shtylyov napsal(a):

>>   Switch to using pci_find_slot() to get to the function 1 of HPT36x/374

> Better to use pci_get_slot()+pci_dev_put(), i. e. refcounting.

    Indeed. I'll recast.

WBR, Sergei

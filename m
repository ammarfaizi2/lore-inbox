Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264379AbUE3Urb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbUE3Urb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUE3Urb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:47:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19879 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264379AbUE3Ur2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:47:28 -0400
Message-ID: <40BA4853.3000504@pobox.com>
Date: Sun, 30 May 2004 16:47:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa_Mancebo?= <ktech@wanadoo.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <200405301954.40111.ktech@wanadoo.es>
In-Reply-To: <200405301954.40111.ktech@wanadoo.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Miguel García Mancebo wrote:
> The same here with nforce2 too. Actually I cannot test that, but I can confirm 
> problems with the ethernet driver in -rc1. Perhaps I can test on tuesday if 
> -rc2 works or the options you mention above.

As I said, there are _zero_ changes to the ethernet driver, therefore it 
is _not_ a problem with the ethernet driver.


> Now that you remember me... I remember seeing one message... something about 
> problems with IRQ # 9.

And indeed, this is more indication it's not a problem with the driver.

ACPI, your BIOS and the Linux PCI core are responsible for getting irq 
routing correct.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbULTJnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbULTJnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULTJnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:43:17 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:65006 "EHLO
	cascabel.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id S261366AbULTJnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:43:09 -0500
Message-ID: <41C69E98.2030807@mtg-marinetechnik.de>
Date: Mon, 20 Dec 2004 10:42:48 +0100
From: Richard Ems <richard.ems@mtg-marinetechnik.de>
Organization: MTG Marinetechnik GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Jon Mason <jdmason@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>	 <89245775041217090726eb2751@mail.gmail.com>	 <41C31421.7090102@mtg-marinetechnik.de>	 <8924577504121710054331bb54@mail.gmail.com> <8924577504121712527144a5cf@mail.gmail.com>
In-Reply-To: <8924577504121712527144a5cf@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer 
  full?" (Plain) (Plain)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Mason wrote:
> Richard,
> Please give the patch below a try (I've also attached it for you
> convienance), and send me the dmesg output from the next time you hit
> the error.

Hi Jon,
I applied your patch, but compiling the module fails.

drivers/net/dl2k.c: In function `rio_tx_timeout':
drivers/net/dl2k.c:567: error: `np' undeclared (first use in this function)
drivers/net/dl2k.c:567: error: (Each undeclared identifier is reported 
only once
drivers/net/dl2k.c:567: error: for each function it appears in.)
drivers/net/dl2k.c: In function `rio_error':


Thanks, Richard

-- 
Richard Ems

MTG Marinetechnik GmbH
Wandsbeker Königstr. 62
22041 Hamburg
Telefon: +49 40 65803 312
TeleFax: +49 40 65803 392
mail: richard.ems@mtg-marinetechnik.de


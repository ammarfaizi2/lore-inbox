Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWBFTn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWBFTn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWBFTnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:43:55 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40394 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932324AbWBFTny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:43:54 -0500
Subject: Re: Linux drivers management
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Chow <davidchow@shaolinmicro.com>
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <43E77E69.8050702@shaolinmicro.com>
References: <43E71AD7.5070600@shaolinmicro.com>
	 <43E71F75.7000605@stud.feec.vutbr.cz>  <43E77E69.8050702@shaolinmicro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 19:45:48 +0000
Message-Id: <1139255148.10437.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-02-07 at 00:50 +0800, David Chow wrote:
> do with talking about a stable kernel API . Even you put the driver 
> sources into the main kernel tree, it will still need a lot of work to 
> port all drivers if the API changes. 

Convention is that he who breaks an API fixes up the majority of the
mess caused or does it by consensus with the other developers. 

Of course if your code is out of tree nobody will know so it'll just
break.

For example the last time I edited the wdt501 watchdog I submitted
according to my logs is about 1998. Since then each person who broke an
API it used fixed it up, or the janitors did shortly afterwards. 

> For different compile time options that affect data structures, this is 
> well known a bad idea .

Do you have measured performance data, economic models and statistical
evidence to back up the claim or is this that well known bad idea called
"conventional wisdom" ?

> operating system" , do you think Linux should one day or some day grow 
> to 1TB source tree to include all possible drivers for all hw come from 
> the world? 

Why not. By the time it gets that big you'll have over 1TB on your phone
let alone a PC. The kernel development structure is optimised for
development. 

Alan


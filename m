Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbUBFKxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 05:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbUBFKxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 05:53:55 -0500
Received: from cpc3-hitc2-5-0-cust51.lutn.cable.ntl.com ([81.99.82.51]:24475
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S265384AbUBFKxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 05:53:54 -0500
Message-ID: <40236207.7050104@reactivated.net>
Date: Fri, 06 Feb 2004 09:44:39 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Craig Bradney <cbradney@zip.com.au>,
       =?ISO-8859-1?Q?Luis_Miguel_G?= =?ISO-8859-1?Q?arc=EDa?= 
	<ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>	 <1076026496.16107.23.camel@athlonxp.bradney.info>	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de>	 <1076029281.23586.36.camel@athlonxp.bradney.info> <40235DBA.4030408@gmx.de> <1076062051.16107.49.camel@athlonxp.bradney.info> <40236F06.5050103@gmx.de>
In-Reply-To: <40236F06.5050103@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Ok, then it makes sense, so you are using APIc with CPU Disconnect and 
> Ross' patch. This explains your low idle temps. As I said this config 
> doesn't work for me.

Have you experimented with the new apic_tack boot options in Ross's latest 
patches?
apic_tack=2 seems to work best for me.

Daniel

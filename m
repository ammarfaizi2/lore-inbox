Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUAFXb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUAFXb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:31:56 -0500
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:35991 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265471AbUAFXbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:31:55 -0500
Message-ID: <3FFB454D.2000002@optushome.com.au>
Date: Wed, 07 Jan 2004 09:31:25 +1000
From: Rohan <rp.m@optushome.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sumit_uconn@lycos.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Card Intel Pro100
References: <BEAEEFBEGJLPJJAA@mailcity.com>
In-Reply-To: <BEAEEFBEGJLPJJAA@mailcity.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sumit Narayan wrote:
> Hi...
> 
> I have loaded the new kernel 2.6.0, but my Ethernet card is not working on it. Its Intel Ether Pro 100B. Could someone help me out with it. Its working perfectly fine with 2.4.21. Is there any special setting to be made for the new kernel? I have used module-init-tools-0.9.14 to install the modules.
> 
> Regrads,
> Sumit
> 

I had a similar problem; works fine on 2.4 but not 2.6.  Turned out the 
module worked, but the kernel wasn't automatically loading it.  Try 
doing 'lsmod' to see if it's loaded (eepro100 I think the module is 
called?) and then 'insmod eepro100' if it's not.

Rohan


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263177AbVGAArq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbVGAArq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 20:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbVGAArq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 20:47:46 -0400
Received: from [62.206.217.67] ([62.206.217.67]:48533 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S263177AbVGAArn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 20:47:43 -0400
Message-ID: <42C492A8.3020702@trash.net>
Date: Fri, 01 Jul 2005 02:47:36 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: chengq <benbenshi@gmail.com>
CC: Denis Vlasenko <vda@ilport.com.ua>, linux-kernel@vger.kernel.org
Subject: Re: route reload after interface restart
References: <dc849d8505063004136573e59e@mail.gmail.com>	 <200506301418.04419.vda@ilport.com.ua> <dc849d850506300711a92042@mail.gmail.com>
In-Reply-To: <dc849d850506300711a92042@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chengq wrote:
>>>Routes relate to ethX were deleted from kernel after i shutdown ethX
>>>(ifconfig ethX down),but after i start ethX (ifconfig ethX
>>>XXX.XXX.XXX.XXX up ),  deleted  routes were not re-add to kernel .

If you specify a netmask for the device a route will be added.

Regards
Patrick


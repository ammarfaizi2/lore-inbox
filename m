Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWDJOiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWDJOiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWDJOiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:38:08 -0400
Received: from fmr17.intel.com ([134.134.136.16]:31963 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751189AbWDJOgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:36:53 -0400
Message-ID: <443A6C38.9000801@intel.com>
Date: Mon, 10 Apr 2006 07:31:20 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5 (X11/20060331)
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>,
       "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
References: <200604071628.30486.vda@ilport.com.ua> <200604100828.20994.vda@ilport.com.ua> <20060409.224559.124326025.davem@davemloft.net> <200604101716.58463.vda@ilport.com.ua>
In-Reply-To: <200604101716.58463.vda@ilport.com.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Monday 10 April 2006 08:45, David S. Miller wrote:
>> From: Denis Vlasenko <vda@ilport.com.ua>
>> Date: Mon, 10 Apr 2006 08:28:20 +0300
>>
>>> IOW: shouldn't calls to these functions sit in
>>> #if defined(CONFIG_VLAN_8021Q) || defined (CONFIG_VLAN_8021Q_MODULE)
>>> block? For example, typhoon.c:
>>>


this should have gone to netdev instead of linux-net.

Cheers,

Auke

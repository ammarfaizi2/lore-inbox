Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVCLEuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVCLEuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 23:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVCLEuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 23:50:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51141 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261688AbVCLEuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 23:50:03 -0500
Message-ID: <423274E5.4060804@pobox.com>
Date: Fri, 11 Mar 2005 23:49:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Christoph Lameter <christoph@graphe.net>
CC: linux-kernel@vger.kernel.org, mark@chelsio.com, netdev@oss.sgi.com
Subject: Re: A new 10GB Ethernet Driver by Chelsio Communications
References: <Pine.LNX.4.58.0503110356340.14213@server.graphe.net> <20050311112132.6a3a3b49.akpm@osdl.org>
In-Reply-To: <20050311112132.6a3a3b49.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christoph Lameter <christoph@graphe.net> wrote:
> 
>>A Linux driver for the Chelsio 10Gb Ethernet Network Controller by
>> Chelsio (http://www.chelsio.com). This driver supports the Chelsio N210
>> NIC and is backward compatible with the Chelsio N110 model 10Gb NICs.
> 
> 
> Thanks, Christoph.
> 
> The 400k patch was too large for the vger email server so I have uploaded it to
> 
>  http://www.zip.com.au/~akpm/linux/patches/stuff/a-new-10gb-ethernet-driver-by-chelsio-communications.patch

step 1:  kill all the OS wrappers.

And do you really need hooks for multiple MACs, when only one MAC is 
really supported?  Typically these hooks are at a higher level anyway -- 
struct net_device.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVFUIuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVFUIuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVFUIsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:48:20 -0400
Received: from cpc4-cmbg4-4-0-cust124.cmbg.cable.ntl.com ([81.108.205.124]:40202
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S262090AbVFUIrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 04:47:21 -0400
Message-ID: <42B7D3D2.8010606@thekelleys.org.uk>
Date: Tue, 21 Jun 2005 09:46:10 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050509 Debian/1.7.6-1ubuntu2.1
X-Accept-Language: en
MIME-Version: 1.0
To: Feyd <feyd@nmskb.cz>
CC: Jirka Bohac <jbohac@suse.cz>, Denis Vlasenko <vda@ilport.com.ua>,
       Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100: firmware problem
References: <20050608142310.GA2339@elf.ucw.cz>	<200506081744.20687.vda@ilport.com.ua>	<20050608145653.GA8844@dwarf.suse.cz>	<42B7C4D0.9070809@thekelleys.org.uk> <20050621102921.5a8c953a@alfa.nmskb.cz>
In-Reply-To: <20050621102921.5a8c953a@alfa.nmskb.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feyd wrote:
> On Tue, 21 Jun 2005 08:42:08 +0100
> Simon Kelley <simon@thekelleys.org.uk> wrote:
> 
> 
>>The atmel driver includes a small firmware stub which does nothing but 
>>determine the MAC address, to solve this problem. This is compiled into 
> 
> 
> Does it power-down the card after reading the MAC?
> 

Yes, it loads the special firmware, runs it to get the MAC, and then 
returns the card to quiesent state, ready for the real firmware load 
which happens at device open time.

Cheers,

Simon.

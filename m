Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbTGNTMO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTGNTMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:12:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270740AbTGNTMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:12:13 -0400
Message-ID: <3F1303FA.8080706@pobox.com>
Date: Mon, 14 Jul 2003 15:26:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: David griego <dagriego@hotmail.com>
CC: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
References: <Sea2-F50x3G5aYY61LE00011019@hotmail.com>
In-Reply-To: <Sea2-F50x3G5aYY61LE00011019@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David griego wrote:
> How does one measure the reliability and security of current software 
> TCP/IP stacks?  Some standard set of test would have to be identified 
> and the TOEs would need to be tested against this to ensure that they 
> meet some minimum standard.  I would suggest offloading the minimum 
> amount from the OS so that most of the control could be maintaind by the 
> OS stack.  This also would make failover/routing changes between TOE 
> -TOE, and TOE-NIC easier.

Anything beyond basic host-only TOE adds massive complexity for very 
little gain:  interfacing netfilter and routing code with a black box we 
_hope_ will act properly sounds like suicide.


 >  Current offloads such as checksum and
> segmentation will not be enough for 10GbE processing, so it would have 
> to be something more than we have today.

All this is vague handwaving without supporting evidence.  So far we get 
stuff like Internet2 speed records _without_ TOE.  And Linux currently 
supports 10gige...  and hosts are just going to keep getting faster and 
faster.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbVKWW4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbVKWW4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbVKWW4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:56:54 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45702 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030471AbVKWW4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:56:52 -0500
Message-ID: <4384F3AD.4080105@pobox.com>
Date: Wed, 23 Nov 2005 17:56:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>	 <4384E7F2.2030508@pobox.com> <1132786445.13095.32.camel@localhost.localdomain>
In-Reply-To: <1132786445.13095.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: >>Additionally, current IOAT is
	memory->memory. I would love to be able >>to convince Intel to add
	transforms and checksums, > > > Not just transforms but also masks and
	maybe even merges and textures > would be rather handy 8) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>Additionally, current IOAT is memory->memory.  I would love to be able 
>>to convince Intel to add transforms and checksums, 
> 
> 
> Not just transforms but also masks and maybe even merges and textures
> would be rather handy 8)


Ah yes:  I totally forgot to mention XOR.

Software RAID would love that.

	Jeff



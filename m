Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUDPFcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDPFcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:32:10 -0400
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:54760 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S262329AbUDPFcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:32:07 -0400
Message-ID: <407F6FF8.1020904@quark.didntduck.org>
Date: Fri, 16 Apr 2004 01:32:40 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How does ioremap() get non-cached mappings
References: <Pine.LNX.4.44.0404161037130.17679-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0404161037130.17679-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar wrote:
> ioremap() function in x86 arch code does not seem to be setting _PAGE_PCD 
> bit in the PTE. How then does it give non-cached mapping to MMIO mappings 
> for memory on some interface card. I have gone thru some old threads on 
> this, which have concluded that it does give non-cached mappings, and 
> moerover ioremap seems to work fine whenever I have used to map any PCI 
> card memory,
> Is it guaranteed thru the means of MTRR ?
> 

ioremap_nocache()

--
				Brian Gerst

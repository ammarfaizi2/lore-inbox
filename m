Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVDES4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVDES4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDESzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:55:22 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1208 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261746AbVDESuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:50:39 -0400
Message-ID: <4252DDE6.5040500@nortel.com>
Date: Tue, 05 Apr 2005 12:50:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josselin Mouette <joss@debian.org>
CC: linux-os@analogic.com, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 	copyright notice.
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br>	 <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet>
In-Reply-To: <1112723637.4878.14.camel@mirchusko.localnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josselin Mouette wrote:

> The fact is also that mixing them with a GPLed software gives
> an result you can't redistribute - although it seems many people
> disagree with that assertion now.

This is only true if the result is considered a "derivative work" of the 
gpl'd code.

The GPL states "In addition, mere aggregation of another work not based 
on the Program with the Program (or with a work based on the Program) on 
a volume of a storage or distribution medium does not bring the other 
work under the scope of this License."

Since the main cpu does not actually run the binary firmware, the fact 
that it lives in main memory with the code that the cpu *does* run is 
irrelevent.  In this case, the Debian stance is that the kernel proper 
and the binary firmware are "merely aggregated" in a volume of storage ( 
ie. system memory).

Chris


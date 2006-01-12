Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWALRMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWALRMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWALRMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:12:32 -0500
Received: from main.gmane.org ([80.91.229.2]:51881 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751412AbWALRMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:12:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Re: Help with machine check exception
Date: Thu, 12 Jan 2006 10:07:58 -0700
Message-ID: <dq62df$gse$1@sea.gmane.org>
References: <dq606p$776$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Mail/News 1.5 (X11/20060103)
In-Reply-To: <dq606p$776$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Orion Poplawski wrote:
> Can someone help determine the problem here?  Does it definitely point 
> to a bad CPU, or possibly a bad motherboard?
> 
> Thanks!
> 


mcelog decode states:

CPU 0 4 northbridge TSC 184fcd0553e4
   Northbridge Watchdog error
        bit57 = processor context corrupt
        bit61 = error uncorrected
   bus error 'generic participation, request timed out
       generic error mem transaction
       generic access, level generic'
STATUS b200000000070f0f MCGSTATUS 4
Kernel panic - not syncing: Machine check


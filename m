Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWJLPbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWJLPbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWJLPbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:31:23 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:58835 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932626AbWJLPbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:31:22 -0400
Message-ID: <452E5FD0.8060309@cfl.rr.com>
Date: Thu, 12 Oct 2006 11:31:28 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>, Phillip Susi <psusi@cfl.rr.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com>
In-Reply-To: <20061012135945.GV17654@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2006 15:31:30.0155 (UTC) FILETIME=[7D5B1BB0:01C6EE13]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14746.003
X-TM-AS-Result: No--11.151500-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define 'handle it correctly'?  The correct thing to do is for dm to 
accept the values and work properly.  dmraid only passes the parameters 
to dm from the on disk data structure created by the bios.

Alasdair G Kergon wrote:
> On Thu, Oct 12, 2006 at 12:01:21AM -0400, Phillip Susi wrote:
>> now dmraid fails to configure the dm 
>> table because this patch rejects it.
>  
>> I believe the correct thing to do is to special case the last stripe in 
>> 0-31    64-67
>> 32-63   68-71
>  
> AFAIK current versions of dmraid handle this correctly - Heinz?
> 
> Alasdair


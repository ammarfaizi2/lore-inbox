Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWHJId1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWHJId1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWHJId1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:33:27 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:18652 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161120AbWHJId0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:33:26 -0400
Message-Id: <44DB0BA7.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 10 Aug 2006 10:34:15 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <stsp@aknet.ru>, "Chuck Ebbert" <76306.1226@compuserve.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
References: <200608100101_MC3-1-C796-F8CA@compuserve.com>
 <44DB0927.76E4.0078.0@novell.com> <200608101026.08606.ak@suse.de>
In-Reply-To: <200608101026.08606.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 10.08.06 10:26 >>>
>On Thursday 10 August 2006 10:23, Jan Beulich wrote:
>> >>> Chuck Ebbert <76306.1226@compuserve.com> 10.08.06 06:59 >>>
>> >Part of the NMI handler is missing annotations.  Just moving
>> >the RING0_INT_FRAME macro fixes it.  And additional comments
>> >should warn anyone changing this to recheck the annotations.
>> 
>> I have to admit that I can't see the value of this movement; 
>
>Should I drop it again? 

I would suggest so, but would also want to wait for Chuck to perhaps
provide some background on why he felt these annotations were
useful.

Jan

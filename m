Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWJSIHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWJSIHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 04:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbWJSIHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 04:07:38 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:26229 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751543AbWJSIHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 04:07:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KtH0Fy8omj2OywP26oHR9tCD+WrGnmL8o55Oc7ojqAC/Qi4VB45gpBHCwogGiJI6zqElRPgN/hfvIgmAiLUwITxaQXCML/W/DviSWPSP575ktuBxFRsQ7JYb5Ndbvnevkjq8AlSP75KPwNbRfMGFztJfGYvNkLk0j41c2hMSQPE=  ;
Message-ID: <45373241.5060203@yahoo.com.au>
Date: Thu, 19 Oct 2006 18:07:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: holt@sgi.com, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com
Subject: Re: exclusive cpusets broken with cpu hotplug
References: <20061017192547.B19901@unix-os.sc.intel.com>	<20061018001424.0c22a64b.pj@sgi.com>	<20061018095621.GB15877@lnx-holt.americas.sgi.com>	<20061018031021.9920552e.pj@sgi.com>	<45361B32.8040604@yahoo.com.au>	<20061018231559.8d3ede8f.pj@sgi.com>	<45371CBB.2030409@yahoo.com.au>	<20061018235746.95343e77.pj@sgi.com>	<4537238A.7060106@yahoo.com.au> <20061019003405.15a4dd8c.pj@sgi.com>
In-Reply-To: <20061019003405.15a4dd8c.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>(we simply shouldn't allow
>>situations where we put a partition in the middle of a cpuset).
> 
> 
> Could you explain to me what you mean by "put a partition in the
> middle of a cpuset?"
> 

Your example, if a partition is created for each of the sub cpusets.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

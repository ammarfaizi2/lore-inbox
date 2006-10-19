Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946295AbWJSSHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946295AbWJSSHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946296AbWJSSHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:07:30 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:9560 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946295AbWJSSH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:07:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=AjlZAAObzW7mbHtq7bwcBzOvqNyJ76V3Rvago96YVPSNd3Iehs3N4eRjyLiVikleRSTm3sUIpQt7zTs6WhA1S6+UAETMW7AoQk3wjObjzQs8OfbVrQ+LFXp9uNmfNFYnb2e+6V+DtJyHSYKPcPoemx0GyN3EjO55MN8TuJYIkp8=  ;
Message-ID: <4537BEDA.8030005@yahoo.com.au>
Date: Fri, 20 Oct 2006 04:07:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>	<453750AA.1050803@yahoo.com.au> <20061019105515.080675fb.pj@sgi.com>
In-Reply-To: <20061019105515.080675fb.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nick wrote:
> 
>>This should be done outside cpusets.
> 
> 
> So ... where should it be done?

sched.c I suppose.

> 
> And what would be better about that other place?

Because it is not a cpuset specific feature.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

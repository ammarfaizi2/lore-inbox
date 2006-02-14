Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWBNJuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWBNJuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbWBNJuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:50:15 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:58208 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030539AbWBNJuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:50:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=PvSk/chOFQmQp2rRHSJZNCJASgwQeJhpj8fOd+04lR2W5/ndiPFYuQZepCqOW+91ikpWpbSxrOMCrIbYdEcwlbnzOeDidGFywGZuhYye6/SCl6b+N5F90kD8un3W3Zi1Z3w860sEs3tYK2YWeFTBcSnon+HHZTJYr64Ypu1w83Y=  ;
Message-ID: <43F196B9.8080407@yahoo.com.au>
Date: Tue, 14 Feb 2006 19:37:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Ingo Molnar'" <mingo@elte.hu>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] fix perf. bug in wake-up load balancing for aim7
 and db workload
References: <200602140312.k1E3CWg17620@unix-os.sc.intel.com>
In-Reply-To: <200602140312.k1E3CWg17620@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Revert commit d7102e95b7b9c00277562c29aad421d2d521c5f6,
> which causes more than 10% performance regression with aim7.
> 

Just to be sure, what kernel did you test with? In particular,
did it have the smpnice patch reverted (as -rc3 does).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

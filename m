Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbWKWAlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbWKWAlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 19:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757240AbWKWAlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 19:41:13 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:22611 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1757243AbWKWAlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 19:41:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ta6d/pnDjySHSjhb+EVSO2/7bqKBzycAgSq9pLm6HAqZhKFppT2dHW2U//O4vNNpAC3fMfy2h5B2Z6aj+yzelKcd3lu/amlNa35jEQVeDB0M9FT/HMmA9jC4sNvlBoEAdgjsxyzMaIKn4hR5t0vuXPpKoCCnj2iuGIwfI/C0n5E=  ;
X-YMail-OSG: wfUmZLcVM1kowwUMQFqpIf6xOrIKeSXwzuk4fs5hHTzVrijT6CWrBwMQH8RrkN.IedZVtb.dmEQDXWZ1aOvmTnmqKR9uUgS.qlcR6VRvUEgLmV.M24JHWA--
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc6: known regressions (v4)
Date: Wed, 22 Nov 2006 16:04:25 -0800
User-Agent: KMail/1.7.1
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-acpi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de>
In-Reply-To: <20061121212424.GQ5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221604.26982.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 1:24 pm, Adrian Bunk wrote:

> Subject    : ACPI: AE_TIME errors
> References : http://lkml.org/lkml/2006/11/15/12
> Submitter  : David Brownell <david-b@pacbell.net>
> Handled-By : Len Brown <len.brown@intel.com>
>              Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
> Status     : problem is being debugged

I've not seen this in over 3 days now, and am willing to believe that
the previous instance (after manually reverting the patch identified
by Linus) was a fluke ... it's certainly not the critical/blocking kind
of issue it had previously been.

- Dave

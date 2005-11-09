Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVKICxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVKICxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 21:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVKICxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 21:53:05 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:3958 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030404AbVKICxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 21:53:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sunMTjFI/7u7QvpUnTb1+LUyqAB5x7frUcb53prBMmEm4Qc/UJLP33mic4D00E9EccAkYCh+0BwMxq643yaQXQmNvvTWp/62UX2klGjzfnpABRUO6RWCaik95C/kHLeaZ3dc1CU1utNBG1deHTEqQSzBnc0l45Rdk3Ay2RgYCD4=  ;
Message-ID: <43716476.1030306@yahoo.com.au>
Date: Wed, 09 Nov 2005 13:52:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rohit Seth <rohit.seth@intel.com>
CC: Paul Jackson <pj@sgi.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
References: <20051107174349.A8018@unix-os.sc.intel.com>	 <20051107175358.62c484a3.akpm@osdl.org>	 <1131416195.20471.31.camel@akash.sc.intel.com>	 <43701FC6.5050104@yahoo.com.au> <20051107214420.6d0f6ec4.pj@sgi.com>	 <43703EFB.1010103@yahoo.com.au> <1131473876.2400.9.camel@akash.sc.intel.com>
In-Reply-To: <1131473876.2400.9.camel@akash.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:

>On Tue, 2005-11-08 at 17:00 +1100, Nick Piggin wrote:
>
>
>>That would be good. I'll send off a fresh patch with the
>>ALLOC_WATERMARKS fixed after Rohit gets around to looking over
>>it.
>>
>>
>
>Nick, your changes have really come out good.  Thanks.  I think it is
>definitely a good starting point as it maintains all of existing
>behavior.
>
>

Great, glad you agree. I'll send the revised copy upstream.

>I guess now I can argue about why we should keep the watermark low for
>GFP_HIGH ;-)
>
>

Yep, I would be happy to discuss this with you and linux-mm :)


Send instant messages to your online friends http://au.messenger.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161096AbVKQDng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161096AbVKQDng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 22:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbVKQDng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 22:43:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43211 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161096AbVKQDnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 22:43:35 -0500
Message-ID: <437BFC61.4000009@us.ibm.com>
Date: Wed, 16 Nov 2005 19:43:29 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: lkml <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
       Anton Blanchard <anton@samba.org>
Subject: Re: 2.6.15-rc1-git4 build failure on ppc64
References: <1132188084.24066.103.camel@localhost.localdomain> <17275.61128.444101.19949@cargo.ozlabs.ibm.com>
In-Reply-To: <17275.61128.444101.19949@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Badari Pulavarty writes:
> 
> 
>>I get following compile error on PPC64 - while trying to compile
>>CONFIG_FLATMEM=y. 
> 
> 
> You have CONFIG_NUMA=y.  According to Anton, NUMA + FLATMEM is an
> invalid combination, but unfortunately the Kconfig doesn't enforce
> that at the moment.  That is, if you want CONFIG_FLATMEM=y, you will
> have to explicitly set CONFIG_NUMA=n.
> 
> Paul.
> 

Okay. Thanks.

- Badari


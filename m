Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUDFGYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUDFGYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:24:04 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:8103 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263629AbUDFGYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:24:02 -0400
Message-ID: <40724CF4.5090705@yahoo.com.au>
Date: Tue, 06 Apr 2004 16:23:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com,
       colpatch@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
References: <20040329041253.5cd281a5.pj@sgi.com>	<1081128401.18831.6.camel@bach>	<20040405000528.513a4af8.pj@sgi.com>	<1081150967.20543.23.camel@bach>	<20040405010839.65bf8f1c.pj@sgi.com>	<1081227547.15274.153.camel@bach> <20040405230601.62c0b84c.pj@sgi.com>
In-Reply-To: <20040405230601.62c0b84c.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> Other than perhaps changing "cpumask_t foo;" to "struct cpumask foo", I
> don't see anything in the 420 lines of code that invokes cpumask
> operations that I think would gain from wholesale changes.

I like cpumask_t. It isn't conceptually a structure, is it?
And you should not need to look inside it or use it with
anything other than using the cpumask interface, right?

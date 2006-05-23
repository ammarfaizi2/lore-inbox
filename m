Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWEWKYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWEWKYj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 06:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWEWKYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 06:24:39 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:20827 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751322AbWEWKYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 06:24:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xjnGvrtOO9qpDhf+1witkzOXHCCJazsQxq7wdXlk/xIQbMq4Kb3ZhGrRJWBXNxoLzdcJ6Ga8Ph/cvkF9eAUvMWaOzXXbHGKJZ3Xszx6nno4We/pGH4CD/9IiuMuvipLxu/zAECGutmpYGmhVcVn4o7w7s9ihOZNx8CQaDlUvMKI=  ;
Message-ID: <4472E2E0.4000201@yahoo.com.au>
Date: Tue, 23 May 2006 20:24:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
CC: kernel@kolivas.org, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. - random reboot problem
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org> <031001c67db1$a8c4a1e0$1800a8c0@dcccs> <200605230112.45564.kernel@kolivas.org> <047401c67de3$a05a52c0$1800a8c0@dcccs> <4472D327.3060808@yahoo.com.au> <013601c67e51$eef03c10$1800a8c0@dcccs>
In-Reply-To: <013601c67e51$eef03c10$1800a8c0@dcccs>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haar János wrote:

> Sorry,  i have allready did these things.
> 
> The motherboard + CPU + RAM successed the overnight memtest, but anyway i
> have replaced this group with another pre-tested ones, but no change!
> (Additionally, i replaced the NIC [e1000 to e1000, and e1000 to realtek],
> the sata cards [promise to promise], the sata and ide cables, mb, cpu, ram,
> ps, and the power cable too.
> Only the 12hdd is the same, but smart reports no errors at all!)
> The power supply is the 3rd. and the problem is the same.

But is the power supply rated enough to support all the drives?
I have seen random reboots where the power supply wasn't good
enough.

> 
> This is really a software bug, but i dont know exactly where.

Could be. memtest doesn't guarantee anything though...

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 

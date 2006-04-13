Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWDMWvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWDMWvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWDMWvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:51:39 -0400
Received: from [62.205.161.221] ([62.205.161.221]:56709 "EHLO kir.sacred.ru")
	by vger.kernel.org with ESMTP id S1750886AbWDMWvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:51:38 -0400
Message-ID: <443ED5F4.1030604@openvz.org>
Date: Fri, 14 Apr 2006 02:51:32 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060217)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: Kirill Korotaev <dev@openvz.org>, Sam Vilain <sam@vilain.net>,
       devel@openvz.org, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143583179.6325.10.camel@localhost.localdomain>	<4429B789.4030209@sacred.ru>	<1143588501.6325.75.camel@localhost.localdomain>	<442A4FAA.4010505@openvz.org>	<20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru>	<1143668273.9969.19.camel@localhost.localdomain>	<443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at>	<443DF523.3060906@openvz.org> <20060413134239.GA6663@MAIL.13thfloor.at> <443EC399.2040307@fr.ibm.com>
In-Reply-To: <443EC399.2040307@fr.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:

> Recently, we've been running tests and benchmarks in different
>
>virtualization environments : openvz, vserver, vserver in a minimal context
>and also Xen as a reference in the virtual machine world.
>
>We ran the usual benchmarks, dbench, tbench, lmbench, kernerl build, on the
>native kernel, on the patched kernel and in each virtualized environment.
>We also did some scalability tests to see how each solution behaved. And
>finally, some tests on live migration. We didn't do much on network nor on
>resource management behavior.
>
>We'd like to continue in an open way. But first, we want to make sure we
>have the right tests, benchmarks, tools, versions, configuration, tuning,
>etc, before publishing any results :) We have some materials already but
>before proposing we would like to have your comments and advices on what we
>should or shouldn't use.
>
>Thanks for doing such a great job on lightweight containers,
>
>C.
>  
>
Cedrik,

You made my day, I am really happy to hear that! Such testing and 
benchmarking should be done by an independent third party, and IBM fits 
that requirement just fine. It all makes much sense for everybody who's 
involved.

If it will be opened (not just results, but also the processes and 
tools), and all the projects will be able to contribute and help, that 
would be just great. We do a lot of testing in-house, and will be happy 
to contribute to such an independent testing/benchmarking project.

Speaking of live migration, we in OpenVZ plan to release our 
implementation as soon as next week.

Regards,
  Kir.

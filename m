Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWDMVdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWDMVdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWDMVdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:33:19 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:12513 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP id S964972AbWDMVdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:33:18 -0400
Message-ID: <443EC399.2040307@fr.ibm.com>
Date: Thu, 13 Apr 2006 23:33:13 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>, Sam Vilain <sam@vilain.net>,
       devel@openvz.org, Kir Kolyshkin <kir@sacred.ru>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143583179.6325.10.camel@localhost.localdomain>	<4429B789.4030209@sacred.ru>	<1143588501.6325.75.camel@localhost.localdomain>	<442A4FAA.4010505@openvz.org>	<20060329134524.GA14522@MAIL.13thfloor.at> <442A9E1E.4030707@sw.ru>	<1143668273.9969.19.camel@localhost.localdomain>	<443CBA48.7020301@sw.ru> <20060413010506.GA16864@MAIL.13thfloor.at>	<443DF523.3060906@openvz.org> <20060413134239.GA6663@MAIL.13thfloor.at>
In-Reply-To: <20060413134239.GA6663@MAIL.13thfloor.at>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:

> well, if the 'results' and 'methods' will be made
> public, I can, until now all I got was something
> along the lines:
> 
>  "Linux-VServer is not stable! WE (swsoft?) have
>   a secret but essential test suite running two 
>   weeks to confirm that OUR kernels ARE stable,
>   and Linux-VServer will never pass those tests,
>   but of course, we can't tell you what kind of
>   tests or what results we got"
> 
> which doesn't help me anything and which, to be 
> honest, does not sound very friendly either ...

Recently, we've been running tests and benchmarks in different
virtualization environments : openvz, vserver, vserver in a minimal context
and also Xen as a reference in the virtual machine world.

We ran the usual benchmarks, dbench, tbench, lmbench, kernerl build, on the
native kernel, on the patched kernel and in each virtualized environment.
We also did some scalability tests to see how each solution behaved. And
finally, some tests on live migration. We didn't do much on network nor on
resource management behavior.

We'd like to continue in an open way. But first, we want to make sure we
have the right tests, benchmarks, tools, versions, configuration, tuning,
etc, before publishing any results :) We have some materials already but
before proposing we would like to have your comments and advices on what we
should or shouldn't use.

Thanks for doing such a great job on lightweight containers,

C.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWFMQmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWFMQmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWFMQmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:42:04 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:60855 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932192AbWFMQmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:42:03 -0400
Message-ID: <448EEAC0.9050504@sw.ru>
Date: Tue, 13 Jun 2006 20:41:36 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       herbert@13thfloor.at, saw@sw.ru, serue@us.ibm.com, sfrench@us.ibm.com,
       sam@vilain.net, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH] IPC namespace
References: <44898BF4.4060509@openvz.org> <m1bqsx4vvf.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1bqsx4vvf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>P.S. patches are against linux-2.6.17-rc6-mm1
> 
> 
> Minor nit.  These patches are not git-bisect safe.
> So if you have to apply them all to get a kernel
> that builds.
> 
> Anyone trying to narrow down breakage is likely to land
> in the middle and hit a compile error.

Yes, these patches are hard to split (like with utsname...)
I splitted them for easier review mostly...

Kirill


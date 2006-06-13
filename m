Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWFMRCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWFMRCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWFMRCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:02:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11972 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932193AbWFMRCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:02:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       herbert@13thfloor.at, saw@sw.ru, serue@us.ibm.com, sfrench@us.ibm.com,
       sam@vilain.net, haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH] IPC namespace
References: <44898BF4.4060509@openvz.org>
	<m1bqsx4vvf.fsf@ebiederm.dsl.xmission.com> <448EEAC0.9050504@sw.ru>
Date: Tue, 13 Jun 2006 11:01:21 -0600
In-Reply-To: <448EEAC0.9050504@sw.ru> (Kirill Korotaev's message of "Tue, 13
	Jun 2006 20:41:36 +0400")
Message-ID: <m1ejxt2dni.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>P.S. patches are against linux-2.6.17-rc6-mm1
>> Minor nit.  These patches are not git-bisect safe.
>> So if you have to apply them all to get a kernel
>> that builds.
>> Anyone trying to narrow down breakage is likely to land
>> in the middle and hit a compile error.
>
> Yes, these patches are hard to split (like with utsname...)
> I splitted them for easier review mostly...

Reasonable.

I'm slowly making my way through reviewing them.

Eric


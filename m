Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWBCKGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWBCKGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWBCKGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:06:22 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:18038 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751157AbWBCKGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:06:22 -0500
Message-ID: <43E32B7B.2000408@sw.ru>
Date: Fri, 03 Feb 2006 13:07:55 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Cedric Le Goater <clg@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>	<43E22DCA.3070004@sw.ru> <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>	<43E27A68.40003@fr.ibm.com> <m1k6cdqvs7.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k6cdqvs7.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Now, would it be possible to have an 'application' container using a
>>private PID space and being friendly to the usual unix process semantics ?
>>We haven't found a solution yet ...
> 
> 
> Well that is what I implemented.  So I am pretty certain it is solvable.
Exactly. This is what our patch does also. It is solvable. Tested by LTP 
and numerous other tests/production systems etc.

Kirill



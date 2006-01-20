Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWATRBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWATRBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWATRBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:01:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44234 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751093AbWATRBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:01:45 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 20 Jan 2006 10:00:13 -0700
In-Reply-To: <1137601395.7850.9.camel@localhost.localdomain> (Dave Hansen's
 message of "Wed, 18 Jan 2006 08:23:15 -0800")
Message-ID: <m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Tue, 2006-01-17 at 20:55 -0800, Greg KH wrote:
>> On Tue, Jan 17, 2006 at 09:25:14AM -0800, Dave Hansen wrote:
>> > 
>> > Arjan had a very good point last time we posted these: we should
>> > consider getting rid of as many places in the kernel where pids are used
>> > to uniquely identify tasks, and just stick with task_struct pointers.  
>> 
>> That's a very good idea, why didn't you do that?
>
> Because we were being stupid and shoudn't have posted this massive set
> of patches to LKML again before addressing the comments we got last
> time, or doing _anything_ new with them.

Actually a little progress has been made.  I think the patch set
continues to the point of usability this time or at least is close.

Although it feels like there are still some gaps when I read through
it.

Eric

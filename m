Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWBBVrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWBBVrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWBBVrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:47:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22707 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932304AbWBBVrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:47:42 -0500
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>
	<20060117143326.283450000@sergelap>
	<1137511972.3005.33.camel@laptopd505.fenrus.org>
	<20060117155600.GF20632@sergelap.austin.ibm.com>
	<1137513818.14135.23.camel@localhost.localdomain>
	<1137518714.5526.8.camel@localhost.localdomain>
	<20060118045518.GB7292@kroah.com>
	<1137601395.7850.9.camel@localhost.localdomain>
	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>
	<43D14578.6060801@watson.ibm.com>
	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>
	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>
	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>
	<43E22DCA.3070004@sw.ru> <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>
	<43E27A68.40003@fr.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Feb 2006 14:46:00 -0700
In-Reply-To: <43E27A68.40003@fr.ibm.com> (Cedric Le Goater's message of
 "Thu, 02 Feb 2006 22:32:24 +0100")
Message-ID: <m1k6cdqvs7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Now, would it be possible to have an 'application' container using a
> private PID space and being friendly to the usual unix process semantics ?
> We haven't found a solution yet ...

Well that is what I implemented.  So I am pretty certain it is solvable.

Eric

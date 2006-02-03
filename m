Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWBCPpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWBCPpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 10:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWBCPpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 10:45:38 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:2996 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750910AbWBCPpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 10:45:38 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <43E335D4.9000401@sw.ru>
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
	 <Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru>
	 <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>	<43E2249D.8060608@sw.ru>
	 <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>	<43E22DCA.3070004@sw.ru>
	 <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>  <43E335D4.9000401@sw.ru>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 07:45:27 -0800
Message-Id: <1138981528.6189.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 13:52 +0300, Kirill Korotaev wrote:
> How can you migrate application which consists of two processes doing 
> IPC via signals? They are not tired inside kernel anyhow and there is
> no way to automatically detect that both should be migrated together.
> VPSs what provides you such kind of boundaries of what should be 
> considered as a whole.

Could you explain a little bit _how_ VPSs provide this?

-- Dave


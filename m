Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423335AbWF1Nxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423335AbWF1Nxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423333AbWF1Nxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:53:43 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:42915 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1750749AbWF1Nxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:53:42 -0400
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Alexey Kuznetsov <alexey@sw.ru>, viro@ftp.linux.org.uk, sam@vilain.net,
       devel@openvz.org, dev@sw.ru, Andrew Morton <akpm@osdl.org>,
       clg@fr.ibm.com, serue@us.ibm.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20060628133640.GB5088@MAIL.13thfloor.at>
References: <20060627133849.E13959@castle.nmd.msu.ru>
	 <44A1149E.6060802@fr.ibm.com> <m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>
	 <20060627160241.GB28984@MAIL.13thfloor.at>
	 <m1psgulf4u.fsf@ebiederm.dsl.xmission.com>
	 <44A1689B.7060809@candelatech.com>
	 <20060627225213.GB2612@MAIL.13thfloor.at>
	 <1151449973.24103.51.camel@localhost.localdomain>
	 <20060627234210.GA1598@ms2.inr.ac.ru>
	 <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>
	 <20060628133640.GB5088@MAIL.13thfloor.at>
Content-Type: text/plain
Organization: unknown
Date: Wed, 28 Jun 2006 09:53:23 -0400
Message-Id: <1151502803.5203.101.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2006-28-06 at 15:36 +0200, Herbert Poetzl wrote:

> note: personally I'm absolutely not against virtualizing
> the device names so that each guest can have a separate
> name space for devices, but there should be a way to
> 'see' _and_ 'identify' the interfaces from outside
> (i.e. host or spectator context)
> 

Makes sense for the host side to have naming convention tied
to the guest. Example as a prefix: guest0-eth0. Would it not
be interesting to have the host also manage these interfaces
via standard tools like ip or ifconfig etc? i.e if i admin up
guest0-eth0, then the user in guest0 will see its eth0 going
up.

Anyways, interesting discussion.

cheers,
jamal


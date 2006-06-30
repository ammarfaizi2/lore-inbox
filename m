Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWF3Bks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWF3Bks (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWF3Bkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:40:47 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:22193 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750938AbWF3Bkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:40:45 -0400
Message-ID: <44A48140.1040702@vilain.net>
Date: Fri, 30 Jun 2006 13:41:20 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: hadi@cyberus.ca, Herbert Poetzl <herbert@13thfloor.at>,
       Alexey Kuznetsov <alexey@sw.ru>, viro@ftp.linux.org.uk,
       devel@openvz.org, dev@sw.ru, Andrew Morton <akpm@osdl.org>,
       clg@fr.ibm.com, serue@us.ibm.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060627133849.E13959@castle.nmd.msu.ru>	<44A1149E.6060802@fr.ibm.com>	<m1sllqn7cb.fsf@ebiederm.dsl.xmission.com>	<20060627160241.GB28984@MAIL.13thfloor.at>	<m1psgulf4u.fsf@ebiederm.dsl.xmission.com>	<44A1689B.7060809@candelatech.com>	<20060627225213.GB2612@MAIL.13thfloor.at>	<1151449973.24103.51.camel@localhost.localdomain>	<20060627234210.GA1598@ms2.inr.ac.ru>	<m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com>	<20060628133640.GB5088@MAIL.13thfloor.at>	<1151502803.5203.101.camel@jzny2> <m1veqlgx91.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1veqlgx91.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>> Makes sense for the host side to have naming convention tied
>> to the guest. Example as a prefix: guest0-eth0. Would it not
>> be interesting to have the host also manage these interfaces
>> via standard tools like ip or ifconfig etc? i.e if i admin up
>> guest0-eth0, then the user in guest0 will see its eth0 going
>> up.
>>     
> Please no.
> [...]
> Now I am open to radically different designs if they allow the
> implementation cost to be lower and they have clean semantics,
> and don't wind up being an ugly unmaintainable wart on the linux
> networking stack.  The only route I could imagine such a thing coming
> from is something like tagging flows, in some netfiler like way.
> Which might allow ifconfig guest-eth0 from the host without problems.
> But I have not seen such a design.
>   

Right.  New tools to support new features would probably be tidier, anyway.

Sam.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932831AbWF1O5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbWF1O5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWF1O5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:57:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38378 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932285AbWF1O5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:57:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Sam Vilain <sam@vilain.net>,
       Andrey Savochkin <saw@swsoft.com>, dlezcano@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       haveblue@us.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>, Mark Huang <mlhuang@CS.Princeton.EDU>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru>
	<m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
	<20060627215859.A20679@castle.nmd.msu.ru>
	<44A1AF37.3070100@vilain.net>
	<m1ac7xkifn.fsf@ebiederm.dsl.xmission.com>
	<44A21F7A.5030807@vilain.net>
	<m1r719ixb6.fsf@ebiederm.dsl.xmission.com> <44A251F2.70707@fr.ibm.com>
	<m1bqsdidhe.fsf@ebiederm.dsl.xmission.com>
	<20060628141539.GA32736@sergelap.austin.ibm.com>
Date: Wed, 28 Jun 2006 08:56:26 -0600
In-Reply-To: <20060628141539.GA32736@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Wed, 28 Jun 2006 09:15:39 -0500")
Message-ID: <m1irmlgwh1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> > I think we're reaching the limits of namespaces. It would be much easier
>> > with a container id in each kernel object we want to isolate.
>> 
>> Nope.  Except for the fact that names are peculiar (sockets, network
>> device names, IP address, routes...) the network stack splits quite cleanly.
>> 
>> I did all of this in a proof of concept mode several months ago and
>> the code is still sitting in my git tree on kernel.org.  I even got
>> the generic stack reference counting fixed.
>> 
>> Eric
>
> Which branch?

It should be the proof-of-concept branch.  It is a development branch so the
history is ugly but the result was fairly decent.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTFUONo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTFUONo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:13:44 -0400
Received: from shell.cyberus.ca ([216.191.236.4]:31756 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id S262525AbTFUONm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:13:42 -0400
Date: Sat, 21 Jun 2003 10:27:16 -0400 (EDT)
From: Jamal Hadi <hadi@shell.cyberus.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, girouard@us.ibm.com,
       stekloff@us.ibm.com, janiceg@us.ibm.com, jgarzik@pobox.com,
       kenistonj@us.ibm.com, lkessler@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
In-Reply-To: <1056199013.25974.27.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <20030621100959.C69143@shell.cyberus.ca>
References: <OFC2446DB8.6D4DA3ED-ON85256D47.007C79EE@us.ibm.com> 
 <20030616.155533.63022973.davem@redhat.com> <1056199013.25974.27.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Jun 2003, Alan Cox wrote:

> On Llu, 2003-06-16 at 23:55, David S. Miller wrote:
> > Let me know when you're back on planet earth ok?
> >
> > Standardizing strings is an absolutely FRUITLESS exercise.
>
> Standardising strings is a real help for end users, but its not the way
> to approach logging issues I agree.

now that xml is the holy grail ive seen people actually
preach xml strings as encoding for protocols ;-> The arguement
i have seen put forward is that strings are easier to read
for users than binary encoding ;-> Therefore they can debug problems.
There maybe cases where this may be valid[1] - the only problem is
a lot of loonies will think this is the next sliced bread.

what about all that bandwidth stoopid xml consumes?
"bandwidth? Who has a problem with bandwidth?;->
what about all that involved processiong of stoopid xml?
"cpu? who has CPU problems?"
Intel has a 10Gige NIC, a 2Mhz cpu, adn 4G DDR Ram for your hungry
applications.
Its a conspiracy i tell ya ;->

cheers,
jamal

[1] For people who use expect for example to send string commands
to a remote system to configure things, when expect (simple req-resp)
becomes too simple you may need something more sophisticated.
They are already sending strings across tcp probably.
Infact a IETF working group has been formed to standardixe this.
http://www.ietf.org/html.charters/netconf-charter.html
theres a draft at :
http://www.ietf.org/internet-drafts/draft-enns-xmlconf-spec-00.txt

The only unfortunate side effect to this is you will see a lot
idjots putting XML in protocols from now on just because.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTF1DN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 23:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbTF1DN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 23:13:56 -0400
Received: from shell.cyberus.ca ([216.191.236.4]:35333 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id S265038AbTF1DNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 23:13:54 -0400
Date: Fri, 27 Jun 2003 23:27:46 -0400 (EDT)
From: Jamal Hadi <hadi@shell.cyberus.ca>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, bcollins@debian.org,
       davidel@xmailserver.org, davem@redhat.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
In-Reply-To: <36630000.1056766403@[10.10.2.4]>
Message-ID: <20030627224649.E90398@shell.cyberus.ca>
References: <20030626.224739.88478624.davem@redhat.com><21740000.1056724453@[10.10.2.4]><Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com><20030627.143738.41641928.davem@redhat.com><Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com><20030627213153.GR501@phunnypharm.org><20030627162527.714091ce.akpm@digeo.com><35240000.1056760723@[10.10.2.4]>
 <20030627181432.61bf6f3a.akpm@digeo.com> <36630000.1056766403@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I think what you need to ensure is a "push"  operation with retransmits.
Obvioulsy the "pull"ing of Dave to bugzilla hasnt worked
(otherwise this discussion wouldnt be happening).

Bug trackers have never worked for me either - in my current day
job i am now passed notifications of every bugzuilla opened. I
actually asked for this because i hate checking bugzilla.
Over time heres what happened:
month 0-3: Read the whole thing and called the owner.
month 4-5: Spent about a 30 second glance and may email somebody
month 6-9: Spend about 30 secs and archive them in a separate maibox
month 9-12: fuck this shit. procmail the whole thing. That what procmail
is for! Maybe someday over a fine cup of Tim Hortons French Vanilla
cappucino and donut i'll go over that list and read them all- if only we
had krispy creme donuts to go with Tim hortons coffee then i am sure i
will read them ;-> The truth is i drink Tim Hortons capucino but still
dont read the damn bugzilla mailbox. But i have it just in case i need
it ...
I can almost swear this is what will happen when you start ccing Dave
on bugzillas.

If you think of Dave as a server then the most reliable protocol
is to retransmit. Under resource constraint he dumps packets
(that del key). Add another server - Alexey - and broadcast to both
via netdev and you start to scale.
I dont think retransmission by a robot would work well either since
it misses that human touch. So you have a challenging task.

cheers,
jamal


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTD1OSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTD1OSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:18:12 -0400
Received: from fluent2.pyramid.net ([206.100.220.213]:3746 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP id S261151AbTD1OSK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:18:10 -0400
X-Not-Legal-Opinion: IANAL I am not a lawyer
X-For-Entertainment-Purposes-Only: True
Message-Id: <5.2.0.9.0.20030428070633.01d630a0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 28 Apr 2003 07:30:15 -0700
To: Matti Aarnio <matti.aarnio@zmailer.org>, Oliver Feiler <kiza@gmx.net>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: [OT] Re: Mailinglist problems?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030428112434.GH24892@mea-ext.zmailer.org>
References: <200304281223.53020.kiza@gmx.net>
 <200304281223.53020.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:24 PM 4/28/03 +0300, Matti Aarnio wrote:
>   Then come various weird things, like overzealous reg-expr message
>   content filters, broken MTA configurations  (don't people ever
>   test that their changes do work ?),  etc...

Smaller operators and a number of company Intranets have SysAdmins who 
don't have a clue how to test changes in their configuration.  They don't 
have "outside" accounts, not even ones a Yahoo or other web-mail places, so 
they can't evaluate their changes.  They also run exactly one mail server 
suite, the production servers, and make changes willy-nilly to the live 
system without fear of consequences.  (Smart mail admins have a test server 
and a way of exercising it -- Mail Admin 101.)

So many clueless Mail Admins I've seen have strange letters, like MCSE, 
after their name.  Also RHCE, I'm sorry to say.  (It's amazing how many 
people put stock in certification, only to learn that it's no bar to true 
twits.  Any sorry tech who knows how to take exams can get most of the 
first- and second-level certifications with ease.  Still sorry admins, but 
sorry admins with paper.)

Developers haven't helped much.  For example, one feature I loved in 
IPCHAINS was the ability to run packets through the software in a testing 
mode and see what happened to them.  I haven't found a similar function in 
IPTABLES yet.  From this comment in the IPTABLES man page, it isn't there yet:

>BUGS
>        Check is not implemented (yet).

(And some joker removed this from later versions of IPTABLES, but there is 
still no "check" option!)

Now, how many MTAs have you encountered that let you "play" mail through 
them to see what happens?  I've used fetchmail to do the job (inject a 
mailstream) on a test system, and that helps quite a bit, but then again I 
know about fetchmail because I once had to deal with ConcentricNet (XO) and 
wanting to run mail sent to my account there through my spam filters, and I 
have quite a corpus of spam mail I have saved just for the purpose.

Getting back to our mutton, until the marketplace requires a certain amount 
of USEFUL knowledge in its administrators (something like the NSFnet days) 
the things you are talking about will continue to be there.

OK, I'll shut up now.

Satch



--
X -> unknown; Spurt -> drip of water under pressure
Expert -> X-Spurt -> Unknown drip under pressure.


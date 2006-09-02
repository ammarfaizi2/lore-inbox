Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWIBMq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWIBMq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 08:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWIBMq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 08:46:28 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:28878 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1751050AbWIBMq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 08:46:27 -0400
Date: Sat, 2 Sep 2006 15:46:26 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Bogofilter at VGER.. (part 2)
Message-ID: <20060902124626.GF16047@mea-ext.zmailer.org>
References: <20060901125153.GC16047@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901125153.GC16047@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 03:51:53PM +0300, Matti Aarnio wrote:
> Hello,
> 
> We are considering of taking Bogofilter into use at VGER.
> So far we are using it in TEST mode - to teach it about
> SPAM and HAM.

Now after some 30 hour message flow for training the filter
has been taken into active use.

It is now able to REJECT things it considers SPAM.

That rejection happens at SMTP input phase, and if your LEGITIMATE
email is now rejected (bounced back to you), do complain to VGER's
POSTMASTER address (postmaster@vger.kernel.org)
That one address is exempted of all content filterings.

We can _try_to_ train the Bayes to accept your email.


> You can feed SPAM to  bogofilter-spam@vger.kernel.org,
> but do not feed there any HAM.  Not that it would
> really affect statistics in any effective way.

My intention was that if you noticed a spam that went
through the list, THEN you can feed that back to the
above mentioned address.  Now several people have fed
their entire spam collections there...

Oh uh..  tons of training material..
Please DO NOT DO IT AGAIN.

We have some secret addresses that we use to teach the system
about HAM and even to untrain previous SPAM score.
We have a number of spam-traps, which I do list below so that
they get wider dissemination and end up in spammers address
lists...  See HTML source of  http://vger.kernel.org/bo.html


Regards,
   Matti Aarnio -- one of  <postmaster@vger.kernel.org>

Trap addresses:

  bogofilter-spam@vger.kernel.org  bo@vger.kernel.org   
  bo--jhsncuk34@vger.kernel.org    bo--jdsclq334@vger.kernel.org
  bo--kewwrl@vger.kernel.org     bo--esafuk@vger.kernel.org
  bo--ihsaju@vger.kernel.org     bo--zfflun@vger.kernel.org
  bo--pgnxao@vger.kernel.org     bo--vbjdos@vger.kernel.org
  bo--iduiri@vger.kernel.org     bo--cjhqmn@vger.kernel.org
  bo--jhpoko@vger.kernel.org     bo--miszpq@vger.kernel.org
  bo--lmorye@vger.kernel.org     bo--zpqotp@vger.kernel.org
  bo--ofurbd@vger.kernel.org     bo--docabv@vger.kernel.org
  bo--rqnsfw@vger.kernel.org     bo--ejqxcj@vger.kernel.org
  bo--tlhntx@vger.kernel.org     bo--vdnygc@vger.kernel.org
  bo--xrhkpa@vger.kernel.org     bo--hdyrzp@vger.kernel.org
  bo--hialfu@vger.kernel.org     bo--knlqpz@vger.kernel.org
  bo--qhcwox@vger.kernel.org     bo--fwzhho@vger.kernel.org
  bo--vtyywu@vger.kernel.org     bo--bnoquf@vger.kernel.org
  bo--sbttra@vger.kernel.org     bo--kwkbnt@vger.kernel.org
  bo--ixdghc@vger.kernel.org     bo--rmlpel@vger.kernel.org
  bo-hamil@vger.kernel.org       bo-mark@vger.kernel.org
  bo-spencer@vger.kernel.org     bo-miller@vger.kernel.org
  bo-lobanov@vger.kernel.org     bo-aarnio@vger.kernel.org
  bo-sipek@vger.kernel.org       bo-garzik@vger.kernel.org


Some of those have two hyphens, some have only one.
Copy and paste freely -- especially if you post to
usenet newsgroups, but make sure you DO NOT let posts
to go to those addresses.  (If you e.g. put them into
your email cc: headers.)
(Single hyphen ones are based on names I saw in my inbox
the other day...  Single prefix + somebody's name.)

-- 
VGER BF report: U 0.5

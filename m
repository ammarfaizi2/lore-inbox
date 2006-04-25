Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWDYMmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWDYMmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWDYMmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:42:22 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:2237 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932212AbWDYMmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:42:21 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Neil Brown <neilb@suse.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <17485.55676.177514.848509@cse.unsw.edu.au>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <1145911526.14804.71.camel@moss-spartans.epoch.ncsc.mil>
	 <17485.55676.177514.848509@cse.unsw.edu.au>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 25 Apr 2006 08:42:29 -0400
Message-Id: <1145968949.17374.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 18:10 +1000, Neil Brown wrote:
> I have a knife with which to eat my dinner, but the moment I move
> it more than 10cm from my plate, a robotic hand reaches out and
> immobilised my hand and hence the knife.  Who is being protected?
> 
> Not me I guess, because the sinful desire to kill has already taken
> over my brain, though maybe I am being protected from life in prison
> for murder.
> 
> Not you because you could still come and jump onto my knife and impale
> yourself, or someone could grab your arm and drag your wrist along the
> blade spilling much of your blood.
> 
> So maybe nobody is being protected.  But somehow, fewer people die
> when the robot arm is active.
> 
> This is how AppArmor works.  It doesn't try to guarantee that no file
> will be corrupted or leak.  It doesn't try to ensure that no bug can ever
> be exploited.  But it does try to minimise harm.  And it succeeds.
> 
> And remember, the robot didn't grab the knife.  It grabbed my hand.
> That is a bit like checking pathnames rather than inodes.  It doesn't
> provide a guarantee of "knife will not enter a body" just as AppArmor
> doesn't guarantee that "file will not be changed".  But is still tends
> to produce the desired result.

I talk to one of the unconfined people at the table and ask them to
rename the "knife" to "spoon".  Now I am free to do what I wish.

You don't care about the name "knife", you care about the object it
represents.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


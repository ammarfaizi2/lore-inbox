Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWDYQw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWDYQw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWDYQw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:52:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60063 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751594AbWDYQwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:52:55 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Arjan van de Ven <arjan@infradead.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Neil Brown <neilb@suse.de>,
       Chris Wright <chrisw@sous-sol.org>, James Morris <jmorris@namei.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <1145983533.21399.56.camel@moss-spartans.epoch.ncsc.mil>
References: <1145470463.3085.86.camel@laptopd505.fenrus.org>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <1145522524.3023.12.camel@laptopd505.fenrus.org>
	 <20060420192717.GA3828@sorel.sous-sol.org>
	 <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <20060424070324.GA14720@thunk.org>
	 <1145912876.14804.91.camel@moss-spartans.epoch.ncsc.mil>
	 <20060424235215.GA5893@thunk.org>
	 <1145983533.21399.56.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 18:52:40 +0200
Message-Id: <1145983961.3114.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But AA specifically emphasizes that it controls capabilities so that
> even a uid 0 process is "confined" by it.  

a scary angle is that a compromised "confined" process can still
reconfigure all your networking to the point that it can forward and NAT
outside connections to any machine on the inside (if the machine acts a
firewall-like role where it can see outside and inside at the same time)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWJCNAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWJCNAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWJCNAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 09:00:45 -0400
Received: from THUNK.ORG ([69.25.196.29]:20932 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932126AbWJCNAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 09:00:44 -0400
Date: Tue, 3 Oct 2006 08:59:44 -0400
From: Theodore Tso <tytso@mit.edu>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003125944.GE2930@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"John W. Linville" <linville@tuxdriver.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Norbert Preining <preining@logic.at>, hostap@shmoo.com,
	ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003123835.GA23912@tuxdriver.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

	Has someone documented somewhere what all of the constraints
are?  I have gathered from various messages that part of the problem
is that different drivers and different userspace tools have a
different idea of what the structures are and what various size fields
mean, and that trying to coordinate changes between the kernel,
multiple userspace tools, and some very popular out-of-tree drivers
(some of which have been kept out of the kernel for issues that I
don't agree with, but which the GPL purists go balistic over), that
you feel that the problem is over-constrained.

	Is there a document or an e-mail message that in one place
describes what the current situation is, why it sucks, what the
changes are, and what eggs are getting broken and why it's better than
where we are today?

	Thanks, regards,

						- Ted

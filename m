Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWGXKwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWGXKwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 06:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGXKwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 06:52:44 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:34762 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932115AbWGXKwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 06:52:44 -0400
Subject: Re: remove cpu hotplug bustification in cpufreq.
From: Arjan van de Ven <arjan@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       davej@redhat.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607231107510.29649@g5.osdl.org>
References: <20060722194018.GA28924@redhat.com>
	 <Pine.LNX.4.64.0607221707400.29649@g5.osdl.org>
	 <20060722180602.ac0d36f5.akpm@osdl.org>
	 <Pine.LNX.4.64.0607221813020.29649@g5.osdl.org>
	 <1153627754.7359.17.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607230955130.29649@g5.osdl.org>
	 <Pine.LNX.4.64.0607231107510.29649@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Jul 2006 12:52:05 +0200
Message-Id: <1153738326.3043.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-23 at 11:12 -0700, Linus Torvalds wrote:
> 
> On Sun, 23 Jul 2006, Linus Torvalds wrote:
> > 
> > Does this work? Hey, it works for me once. It's pretty simple, and had 
> > better not have any recursion issues.
> 
> GAAH!!
> 
> What kind of _crap_ is this cpufreq thing?


this is why lockdep got highly upset with it, and why Davej proposed to
remove the locking entirely for now until it can be put back in a
correct way....

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWDUCMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWDUCMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 22:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWDUCMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 22:12:10 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31105 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750716AbWDUCMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 22:12:09 -0400
Date: Thu, 20 Apr 2006 19:09:29 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: "Linda A. Walsh" <law@tlinx.org>
Cc: Christoph Hellwig <hch@infradead.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace	semaphore
Message-ID: <20060421020929.GG3828@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil> <20060420124647.GD18604@sergelap.austin.ibm.com> <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil> <20060420132128.GG18604@sergelap.austin.ibm.com> <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil> <44480727.9010500@tlinx.org> <20060420230551.GA5026@infradead.org> <4448355F.7070509@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4448355F.7070509@tlinx.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linda A. Walsh (law@tlinx.org) wrote:
>    "The *current* accepted way to get pathnames going into system calls is
> to put a trap in the syscall vector processing code to be indirectly
> called through the ptrace call with every system call as audit currently 
> does..."?
> 
>    Or is that not correct either?

No it's not.  See getname(9).

thanks,
-chris

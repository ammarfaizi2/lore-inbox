Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVIEE0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVIEE0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 00:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVIEE0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 00:26:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41427 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932200AbVIEE0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 00:26:54 -0400
Date: Mon, 5 Sep 2005 00:26:41 -0400
From: Dave Jones <davej@redhat.com>
To: Alex Davis <alex14641@yahoo.com>
Cc: Sean <seanlkml@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050905042641.GD4715@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alex Davis <alex14641@yahoo.com>, Sean <seanlkml@sympatico.ca>,
	linux-kernel@vger.kernel.org
References: <36918.10.10.10.10.1125889201.squirrel@linux1> <20050905034158.97152.qmail@web50213.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905034158.97152.qmail@web50213.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 08:41:58PM -0700, Alex Davis wrote:
 
 > It will never be 'appropriate' if the system doesn't somehow work on Joe's
 > hardware. We currently have something that works.

"works".

As someone who gets to read a lot of bug reports from end-users,
this thing is far from perfect judging by the number of tainted
oopses I've seen, and not all of them look like stack size issues.

The fact is these situations are undebuggable. Where does that
leave users ?

 > Please explain how Linux can be an 'important force' if people can't
 > use it? Wireless networking is very important to people.

There are plenty of cards available, which work just fine with
free drivers.

 > Um, ever hear of 'compromise'?? All I'm saying is let people use what
 > currently works until we can get an open-source solution. Ndiswrapper's
 > existence is not stopping you (or anyone else) from pestering manufacturers
 > for spec's and writing drivers. I look at ndiswrapper as a stop-gap solution.

A lot of users look at it as nirvana. I've seen users report bugs against
ancient kernels, that are extremely likely to be fixed in later kernels,
yet they're unwilling to move to a newer kernel due to them being tied
to a driver that only works on an older kernel, despite the fact that there
are known security and data corruption issues with the older kernels.

Helping the cause of binary (or part binary) solutions doesn't solve anything.
It brings nothing but unsolvable problems, and upset users when their problems
can't get fixed.

		Dave


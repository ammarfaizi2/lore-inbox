Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTDIRYQ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 13:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263635AbTDIRYQ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 13:24:16 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:30345 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S263632AbTDIRYP (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 13:24:15 -0400
Date: Wed, 09 Apr 2003 11:34:01 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chuck Ebbert <76306.1226@compuserve.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges (was:	[MAILER-DAEMON@rumms.u
Message-ID: <194120000.1049909641@aslan.btc.adaptec.com>
In-Reply-To: <1049886804.9901.19.camel@dhcp22.swansea.linux.org.uk>
References: <200304082124_MC3-1-3399-FBD0@compuserve.com> <1049886804.9901.19.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mer, 2003-04-09 at 02:21, Chuck Ebbert wrote:
>> And your code goes for long periods of time without merging good fixes,
>> like this one (from 2.4.20):
> 
> Which is one reason Justin's patches don't get merged. They are giant
> changes which back out other clear corrections.

This tells me two things:

1) You don't trust maintainers.  If a maintainer can't make large changes,
   who can?

2) When a maintainer makes a mistake (fails to integrate a good change,
   or introduces a bug), the maintainers changes are simply dropped rather
   then notify (either politely or not I don't much care) the maintainer
   of his/her mistake.

Neither of the above applied to integration of the aic79xx driver into
the 2.4.X tree, but it still took something like 8 months.

There must be a better way.

--
Justin


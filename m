Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUCPT7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCPT6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:58:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:24523 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261605AbUCPT6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:58:39 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: deactivate dm disks?
Date: Tue, 16 Mar 2004 13:58:05 -0600
User-Agent: KMail/1.6
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
References: <20040315205650.A11865@animx.eu.org> <200403160917.03810.kevcorry@us.ibm.com> <20040316142226.A13765@animx.eu.org>
In-Reply-To: <20040316142226.A13765@animx.eu.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403161358.05917.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 1:22 pm, Wakko Warner wrote:
> > > I also noticed it wanted to grab my partitions on sda which were
> > > already mounted and couldn't grab them.
> >
> > Again, you can add an "exclude" entry in your /etc/evms.conf if you want
> > EVMS to ignore sda. Otherwise, have a look at
> > http://evms.sf.net/install/kernel.html#bdclaim
>
> I think I'll only give it disks that I want in evms.  The "sde" is a USB
> disk that I move around alot.
>
> If you're not the right person to ask, please direct me to someone else.
> I was going to do a raid5 across a few disks (this is in the future not
> now).  Is there any way to add disks to that raid5 using evms?

I'm one of the right people to ask about EVMS. Please send questions to 
evms-devel@lists.sf.net and the whole group will be able to provide 
assistance.

EVMS will recognize and manage software raid devices, but currently doesn't 
support expanding raid-5 devices. It's on our list for later this year. I 
believe there's a stand-alone tool available that will let you do this 
(google for raidreconf).

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264683AbUD1Hwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbUD1Hwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 03:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264684AbUD1Hwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 03:52:40 -0400
Received: from p213.54.6.152.tisdip.tiscali.de ([213.54.6.152]:60683 "EHLO
	mail.our-home.net") by vger.kernel.org with ESMTP id S264683AbUD1Hwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 03:52:39 -0400
Message-Id: <37355407.b2srnFq9xu@rohde-29233.user.cis.dfn.de>
From: Henning Rohde <Rohde.Henning@gmx.net>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
To: linux-kernel@vger.kernel.org
Date: Wed, 28 Apr 2004 09:52:40 +0200
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Viro,

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Apr 27, 2004 at 10:39:09PM +0200, Grzegorz Kulewski wrote:
>> > c) nobody sane should put that as default.  Oh, wait, it's gentoo
>> > we are talking about?  Nevermind, then.
>> 
>> But what default? Gentoo just calls evms_activate before mounting
>> filesystems to check if there are evms volumes (because filesystems can
>> reside on it). And, according to man page, this is the right usage of
>> evms_activate.
> 
> And that usage of evms_activate takes over all normally partitioned
> devices
> and shoves equivalents of partitions under /dev/evms, right?  So in which
> universe would that be the right thing to do without a big fat warning and
> update of /etc/fstab?

please have a look at http://evms.sourceforge.net/install/kernel.html,
chapter 3, part E: BD-Claim Patch.

Just my 2 cents of EUR,

        Henning Rohde

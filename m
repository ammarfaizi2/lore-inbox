Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030624AbWHIJ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030624AbWHIJ4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWHIJ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:56:41 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:13619 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030629AbWHIJ4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:56:40 -0400
Date: Wed, 9 Aug 2006 12:56:35 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
       =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060809095635.GH3725@rhun.haifa.ibm.com>
References: <20060808122234.GD5497@rhun.haifa.ibm.com> <20060808125652.GA5284@ucw.cz> <20060808131724.GE5497@rhun.haifa.ibm.com> <41840b750608080635j552829a3g4971316ff2d264ad@mail.gmail.com> <20060808134337.GF5497@rhun.haifa.ibm.com> <41840b750608080753v27a0ce16xf4da0ad177b08657@mail.gmail.com> <1155050380.5729.89.camel@localhost.localdomain> <41840b750608080833p6e7cfffx890f9c4732b93e73@mail.gmail.com> <20060809034434.GA4665@rhun.haifa.ibm.com> <41840b750608090202k4dcac1b3h38c1f98d398af479@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750608090202k4dcac1b3h38c1f98d398af479@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 12:02:39PM +0300, Shem Multinymous wrote:

> If we'll need to lock away ACPI (just matter of time, my guess), we'll
> stumble upon the non-interruptible down()s deep inside in the ACPI
> code. So we can't guarantee and shouldn't promise it's really
> interruptible.

Ok, I concede :-)

> It's not that strange that a function might fail even if it's named
> "do_something()", you know. It's down() that forms an exception - it's
> so simple we know it can't fail.

>From a maintainer point of view, anything that is non-idiomatic is a
pain. Since there is no idiomatic way to express what you want, you
get to choose the idiom.

Cheeers,
Muli

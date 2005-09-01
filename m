Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVIAVM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVIAVM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbVIAVM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:12:59 -0400
Received: from [203.171.93.254] ([203.171.93.254]:33196 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030381AbVIAVM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:12:58 -0400
Subject: Re: reboot vs poweroff
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <m164tkpryx.fsf@ebiederm.dsl.xmission.com>
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	 <1125557333.12996.76.camel@localhost>
	 <Pine.SOC.4.61.0509011030430.3232@math.ut.ee> <4316F4E3.4030302@drzeus.cx>
	 <1125578897.4785.23.camel@localhost>
	 <m1fysoq0p7.fsf@ebiederm.dsl.xmission.com> <43171C02.30402@drzeus.cx>
	 <m1aciwpvsz.fsf@ebiederm.dsl.xmission.com> <43174643.7040007@drzeus.cx>
	 <m164tkpryx.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1125609100.4785.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 02 Sep 2005 07:11:40 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-09-02 at 04:23, Eric W. Biederman wrote:
> Pierre Ossman <drzeus-list@drzeus.cx> writes:
> >
> > Patch tested and works fine here. You should probably make a note in the
> > bugzilla so we don't get a conflicting merge from the ACPI folks.
> 
> Thanks.
> 
> If I can figure out bugzilla...
> 
> > I suppose Nigel should use this function in swsusp2 aswell?

All I did was start calling pm_ops->prepare, ->enter and ->finish
regardless of the powerdown method, instead of only for S3 or S4. It
seems to be working fine. If, however, we should be doing things
differently, I'm happy to comply. What's the authoritative word?

Regards,

Nigel

> If he is doing the same thing yes.
> 
> Eric
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


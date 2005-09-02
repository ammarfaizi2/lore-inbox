Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030681AbVIBErM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030681AbVIBErM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 00:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030682AbVIBErM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 00:47:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7880 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030681AbVIBErL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 00:47:11 -0400
To: ncunningham@cyclades.com
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	<1125557333.12996.76.camel@localhost>
	<Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
	<4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost>
	<m1fysoq0p7.fsf@ebiederm.dsl.xmission.com> <43171C02.30402@drzeus.cx>
	<m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
	<43174643.7040007@drzeus.cx>
	<m164tkpryx.fsf@ebiederm.dsl.xmission.com>
	<1125609100.4785.30.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 01 Sep 2005 22:46:08 -0600
In-Reply-To: <1125609100.4785.30.camel@localhost> (Nigel Cunningham's
 message of "Fri, 02 Sep 2005 07:11:40 +1000")
Message-ID: <m1r7c8nkkv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> writes:

>
> All I did was start calling pm_ops->prepare, ->enter and ->finish
> regardless of the powerdown method, instead of only for S3 or S4. It
> seems to be working fine. If, however, we should be doing things
> differently, I'm happy to comply. What's the authoritative word?

Not certain.  I am only authoritative on device_suspend() and the
reboot_notifiers, in this context.  Largely I read and think about
the code to see what is going on.

Eric

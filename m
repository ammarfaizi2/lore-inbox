Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWCAOfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWCAOfR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWCAOfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:35:17 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:26813 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S932229AbWCAOfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:35:16 -0500
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
References: <20060227190150.GA9121@kroah.com> <p7364n01tv3.fsf@verdi.suse.de>
	<20060227194400.GB9991@suse.de>
	<20060301135356.GC23159@marowsky-bree.de>
	<20060301141031.GC17561@boogie.lpds.sztaki.hu>
From: Jes Sorensen <jes@sgi.com>
Date: 01 Mar 2006 09:35:14 -0500
In-Reply-To: <20060301141031.GC17561@boogie.lpds.sztaki.hu>
Message-ID: <yq0d5h66xnh.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Gabor" == Gabor Gombas <gombasg@sztaki.hu> writes:

Gabor> On Wed, Mar 01, 2006 at 02:53:56PM +0100, Lars Marowsky-Bree
Gabor> wrote:
>> The fact is that now we have user-space and kernel space tied
>> together much more intimately than ever; udev & sysfs being the
>> prime examples these days, and then it's not that some figure in
>> top is wrong, but "oops my network no longer loads and the box is
>> 400 miles away".

Gabor> IMHO this is not a good example as there is really no reason to
Gabor> install udev on such a box at all. Remember: KISS. Having a
Gabor> static /dev and /etc/modules filled in (or even better, a
Gabor> monolithic kernel) is far more reliable to administer.

Gabor> On a desktop machine when you are plugging in various
Gabor> USB/Firewire/etc.  devices all the time udev works great. On a
Gabor> remote server there is no real need for udev.

Problem is that a lot of sites rely on 'enterprise' distros (SLES,
RHEL, etc.), so if those use udev, the users will end up with it as
well.

Cheers,
Jes

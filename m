Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbUKSOtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUKSOtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 09:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUKSOtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 09:49:31 -0500
Received: from zamok.crans.org ([138.231.136.6]:31948 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261431AbUKSOt1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 09:49:27 -0500
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>,
       Hotplug Devel <linux-hotplug-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 046 release
References: <20041118224411.GA10876@kroah.com>
	<87sm76oz9z.fsf@barad-dur.crans.org>
	<1100875339.18701.3.camel@localhost.localdomain>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Fri, 19 Nov 2004 15:49:25 +0100
In-Reply-To: <1100875339.18701.3.camel@localhost.localdomain> (Kay Sievers's
	message of "Fri, 19 Nov 2004 15:42:19 +0100")
Message-ID: <87654199my.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers <kay.sievers@vrfy.org> disait dernièrement que :

> On Fri, 2004-11-19 at 12:26 +0100, Mathieu Segaud wrote:
>> seems like these changes broke something in rules applying to eth* devices.
>> the rules put and still working with udev 045 have no effect, now....
>> not so inconvenient now that I've got just one card in my box, but I guess
>> it could be a show-stopper for laptop users.
>> 
>> My rules which can be found at the end of /etc/udev/rules.d/50-udev.rules are:
>> 
>> KERNEL="eth*", SYSFS{address}="00:10:5a:49:36:d8", NAME="external"
>> KERNEL="eth*", SYSFS{address}="00:50:04:69:db:56", NAME="private"
>> KERNEL="eth*", SYSFS{address}="00:0c:6e:e4:2c:81", NAME="dmz"
>
> This should fix it.

will report success as soon as I create the ebuild, test it and I submit it to
greg-kh.
btw, thanks for the quick answer.

-- 
... mindreading equipment is currently classified CIA property at
best (hello echelon!)

	- Alan Cox on linux-kernel


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTICJqP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 05:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTICJqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 05:46:15 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:2498 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261722AbTICJqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 05:46:14 -0400
Date: Wed, 3 Sep 2003 11:46:11 +0200
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: dth@ncc1701.cistron.net, rl@hellgate.ch, deimos@deimos.one.pl,
       arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Message-ID: <20030903114611.C3655@pc9391.uni-regensburg.de>
References: <20030903113737.A3655@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030903113737.A3655@pc9391.uni-regensburg.de>; from Christian.Guggenberger@physik.uni-regensburg.de on Wed, Sep 03, 2003 at 11:37:37 +0200
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> Roger Luethi   wrote:
>> vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem to 
>> work.
> Try a kernel without ACPI and/or APIC support.

> Yup, adding acpi=off "fixed" the problem.
> Will wait for "better" times ! ;-)

Some days ago a patch for 2.6 has been posted on bugzilla, (see some of the 
last entries of Bug #10).
This one got IO-APIC + ACPI working for the first time in a year on my EPOX 
8k5a3+.
(via-rhine, usb , sound )

Please try !

Christian
P.S. there's also a patch for 2.4 (search for "Fixing USB interrupts problems" 
in the subject)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUCRIAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbUCRIAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:00:18 -0500
Received: from upco.es ([130.206.70.227]:37350 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261926AbUCRIAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:00:14 -0500
Date: Thu, 18 Mar 2004 09:00:12 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Remove pmdisk from kernel
Message-ID: <20040318080012.GA857@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>
References: <20040315195440.GA1312@elf.ucw.cz> <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz> <20040316091648.GB6301@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040316091648.GB6301@pern.dea.icai.upco.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 10:16:48AM +0100, I wrote:

> Are you sure swsusp is equivalent? Last time I tried (2.6.1, I am in serious
> time shortage in this period) swsusp did not work on my Vaio fx-701, while
> PMDISK yes (ACPI enabled). I will try to test again in this weekend. 

Well, I can confirm that, as Mr. Machek said, swsusp and pmdisk gave me the
same functionality on a Vaio fx-701 laptop. I do not know why 2.6.1 didn't
work, but there have been a lot of ACPI updates, maybe that's the key. 

Before suspending I unload pcmcia, sound (alsa), autofs, and usb hid
modules. If someone is interested I canb try not to unload something an
report back what happens. 

I will try during the long weekend (tomorrow's holiday here) the bleeding
edge patches from Nigel, and report back. 

Thanks to all,
              Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569

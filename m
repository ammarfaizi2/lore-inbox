Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVBPOk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVBPOk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVBPOk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:40:27 -0500
Received: from sd291.sivit.org ([194.146.225.122]:49627 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262027AbVBPOkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:40:17 -0500
Date: Wed, 16 Feb 2005 15:41:59 +0100
From: Stelian Pop <stelian@popies.net>
To: Romano Giannetti <romanol@upco.es>, Vojtech Pavlik <vojtech@suse.cz>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050216144156.GA4372@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Romano Giannetti <romanol@upco.es>, Vojtech Pavlik <vojtech@suse.cz>,
	Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr> <20050214203211.GA8007@ucw.cz> <20050215161412.GC20951@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215161412.GC20951@pern.dea.icai.upco.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 05:14:12PM +0100, Romano Giannetti wrote:

> On Mon, Feb 14, 2005 at 09:32:11PM +0100, Vojtech Pavlik wrote:
> >  
> > Yes, I'd like to see that. The other possible way is have the input
> > layer generate ACPI events for power-related keys.
> > 
> 
> I beg your pardon, but I have a very strange problem with ACPI event on a
> Sony laptop. Probably it's completely unraleted, but if you have time to
> have a look, it is on bugzilla too:
> 
> http://bugme.osdl.org/show_bug.cgi?id=4124

Strange indeed.

First thing to test is to disable sonypi (either rebuild a kernel
without it or rename the module so it will not get loaded again),
then reboot and see if you still have problems.

If you do, the problem is ACPI/input related.

If you don't, the strangeness comes from some interraction with
sonypi.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

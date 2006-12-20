Return-Path: <linux-kernel-owner+w=401wt.eu-S932626AbWLTA0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWLTA0A (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWLTA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:26:00 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:39687 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626AbWLTAZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:25:59 -0500
Date: Wed, 20 Dec 2006 00:25:46 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Message-ID: <20061220002546.GA17378@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <1166559785.3365.1276.camel@laptopd505.fenrus.org> <20061219203251.GA14648@srcf.ucam.org> <200612191334.49760.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612191334.49760.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to sysfs PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 01:34:49PM -0800, David Brownell wrote:

> Documentation/feature-removal-schedule.txt has warned about this since
> August, and the PM list has discussed how broken that model is numerous
> times over the past several years.  (I'm pretty sure that discussion has
> leaked out to LKML on occasion.)  It shouldn't be news today.

1) feature-removal-schedule.txt says that it'll be removed in July 2007. 
This isn't July 2007.

2) The functionality was disabled in 2.6.19. The addition to 
feature-removal-schedule.txt was in, uh, 2.6.19.

3) "The whole _point_ of a kernel is to act as a abstraction layer and 
resource management between user programs and hardware/outside world. 
That's why kernels _exist_. Breaking user-land API's is thus by 
definition something totally idiotic.

If you need to break something, you create a new interface, and try to 
translate between the two, and maybe you deprecate the old one so that 
it can be removed once it's not in use any more. If you can't see that 
this is how a kernel should work, you're missing the point of having a 
kernel in the first place."

Linus, http://lkml.org/lkml/2006/10/4/327

-- 
Matthew Garrett | mjg59@srcf.ucam.org

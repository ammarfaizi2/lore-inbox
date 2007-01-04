Return-Path: <linux-kernel-owner+w=401wt.eu-S1750977AbXADTVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXADTVy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbXADTVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:21:54 -0500
Received: from aa014msr.fastwebnet.it ([85.18.95.74]:33792 "EHLO
	aa014msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbXADTVw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:21:52 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 14:21:52 EST
Date: Thu, 4 Jan 2007 20:15:12 +0100
From: Mattia Dongili <malattia@linux.it>
To: Stelian Pop <stelian@popies.net>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-ID: <20070104191512.GC25619@inferi.kami.home>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>,
	Ismail Donmez <ismail@pardus.org.tr>,
	Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1167905384.7763.36.camel@localhost.localdomain>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.20-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 11:09:44AM +0100, Stelian Pop wrote:
> Le jeudi 04 janvier 2007 à 00:24 -0500, Len Brown a écrit :
> 
> > > > I'd like to keep this driver out-of-tree
> > > > until we prove that we can't enhance the
> > > > generic code to handle this hardware
> > > > without the addition of a new driver.
> > > 
> > > How long is this going to take ?
> > 
> > How about 2.6.21?
> 
> Good news !
> 
> > What needs to happen is
> > 1. a maintainer for sony_acpi.c needs to step forward
> >     I can't do this, I'm not allowed to be in the reverse engineering business.
> 
> Well, I can't do this either, because I just don't have the required
> hardware anymore.
> 
> If someone want to step forward now it is a great time !

I have the hw and I'd be happy to do some basic working on the code
but:
- I'll probably need some help;
- I'll have an almost-blackout between the end of February and the end
  of April as I'm moving to a different country and I'll need some time
  before I can be active again (I hope I'll have at least easy mail
  access for all the time though).
Anyway if it is still ok I can maintain the thing, to months seems
enough to give the driver a shape.

> > 2. /proc/acpi/sony API needs to be deleted
> > 
> > 3. source needs to move out of drivers/acpi, and into drivers/misc along with msi.

And turn extra-backlight features into platform_device stuff? So 2 and 3
can come together.

Moreover, I own an SZ72B and an older GR7 and have come to the same
findings of Cacy, plus a patch to allow a smarter "debug" mode.
So, how to proceed? (I've just cloned the linux-acpi-2.6 tree)

Thanks Len, Thanks Stelian
-- 
mattia
:wq!

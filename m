Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVJNJkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVJNJkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVJNJkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:40:31 -0400
Received: from [213.91.10.50] ([213.91.10.50]:56781 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1751087AbVJNJka convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:40:30 -0400
X-DomainKeys: Sendmail DomainKeys Filter v0.3.0 zone4.gcu-squad.org j9E9OXG0023528
X-DKIM: Sendmail DKIM Filter v0.1.1 zone4.gcu-squad.org j9E9OXG0023528
Date: Fri, 14 Oct 2005 11:24:29 +0200 (CEST)
To: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <vJmVlab2.1129281869.1524300.khali@localhost>
In-Reply-To: <200510132128.45171.jesper.juhl@gmail.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Andrew Morton" <akpm@osdl.org>, "Len Brown" <len.brown@intel.com>,
       "iss_storagedev@hp.com" <iss_storagedev@hp.com>,
       "Jakub Jelinek" <jj@ultra.linux.cz>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Jens Axboe" <axboe@suse.de>, "Roland Dreier" <rolandd@cisco.com>,
       "Sergio Rozanski Filho" <aris@cathedrallabs.org>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Pierre Ossman" <drzeus-wbsd@drzeus.cx>,
       "Carsten Gross" <carsten@sol.wh-hms.uni-ulm.de>,
       "Greg Kroah-Hartman" <greg@kroah.com>,
       "David Hinds" <dahinds@users.sourceforge.net>,
       "Vinh Truong" <vinh.truong@eng.sun.com>,
       "Mark Douglas Corner" <mcorner@umich.edu>,
       "Michael Downey" <downey@zymeta.com>,
       "Antonino Daplas" <adaplas@pol.net>,
       "Ben Gardner" <bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.1 (zone4.gcu-squad.org [127.0.0.1]); Fri, 14 Oct 2005 11:24:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jesper,

On 2005-10-13, Jesper Juhl wrote:
> This is the remaining misc drivers/ part of the big kfree cleanup patch.
>
> Remove pointless checks for NULL prior to calling kfree() in misc files
> in drivers/.

The hwmon and i2c parts are fine by me.

Acked-by: Jean Delvare <khali@linux-fr.org>

BTW, what's the merge plan? Andrew enqueues the whole stuff, or do you
expect each individual maitainer to extract his/her part?

Thanks,
--
Jean Delvare

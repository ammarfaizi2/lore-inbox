Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVEPLab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVEPLab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEPLaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:30:30 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31646 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261560AbVEPLaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:30:00 -0400
Date: Mon, 16 May 2005 13:29:56 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
Message-ID: <20050516112956.GC13387@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116241957.6274.36.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Arjan van de Ven wrote:

> I think you missed the part where disabling the writecache decreases the
> mtbf of your disk by like a factor 100 or so. At which point your
> dataloss opportunity INCREASES by doing this.

Nah, if that were a factor of 100, then it should have been in the OEM
manuals, no?

Besides that, although my small sample is not representative, I have
older drives still alive & kicking - an MTBF of 1/100 of what the vendor
stated would mean the chance of failure way above 90 % by now, the drive
has seen 22,000 POH with write cache off and has been a system drive for
like 14,000 POH. So?

> Sure you can waive rethorics around, but the fact is that linux is
> improving; there now is write barrier support for ext3 (and I assume
> reiserfs) for at least IDE and iirc selected scsi too. 

See the problem: "I assume", "IIRC selected...". There is no
list of corroborated facts which systems work and which don't. I have
made several attempts in compiling one, posting public calls for data
here, no response.

I don't blame you personally, but the lack of documentation about such
crucial facts or generally documentation in Linux environments in general.

-- 
Matthias Andree

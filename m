Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWAMNts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWAMNts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWAMNts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:49:48 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:62917 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422671AbWAMNtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:49:47 -0500
Subject: Re: [patch 1/13] s390: des crypto code cleanup.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060113125808.GA1868@elf.ucw.cz>
References: <20060112171404.GB16629@skybase.boeblingen.de.ibm.com>
	 <20060113125808.GA1868@elf.ucw.cz>
Content-Type: text/plain; charset=iso-8859-2
Date: Fri, 13 Jan 2006 14:49:52 +0100
Message-Id: <1137160192.6192.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 13:58 +0100, Pavel Machek wrote:
> On Èt 12-01-06 18:14:04, Martin Schwidefsky wrote:
> > From: Jan Glauber <jan.glauber@de.ibm.com>
> > 
> > [patch 1/13] s390: des crypto code cleanup.
> > 
> > Beautify the s390 in-kernel-crypto des code.
> > 
> > Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Why does s390 need to do des in arch-specific code, BTW? Is it driver
> for some crypto accelerator or what?

Yes, the z900 and following machines have processor instructions to
speed up the crypto algorithms. There are instructions for sha1, sha256,
des and aes. They provide a good speedup, with the latest code des is up
to a factor of 40 faster than the software implementation.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH



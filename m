Return-Path: <linux-kernel-owner+w=401wt.eu-S1161135AbWLPQQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbWLPQQz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWLPQQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:16:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43229 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161135AbWLPQQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:16:54 -0500
Date: Sat, 16 Dec 2006 11:16:47 -0500
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_via: Cable detect error
Message-ID: <20061216161647.GG23368@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, Alan <alan@lxorguk.ukuu.org.uk>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20061216143221.47c5e7f3@localhost.localdomain> <45841525.7040406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45841525.7040406@pobox.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 10:47:49AM -0500, Jeff Garzik wrote:

 > I think it's #upstream-fixes material (-rc material), and applied as such.
 > 
 > Especially considering that libata pata_* drivers are not the primary 
 > drivers, I think it's best to forward this type of stuff, especially as 
 > it is indeed IMO a fix worth having.

They may not be primary today, but it's not going to be very long
at all before that situation changes.  AFAIK, most of (if not all) the major
distros basing on 2.6.19+ are moving to using the libata PATA drivers in
their next releases.

		Dave

-- 
http://www.codemonkey.org.uk

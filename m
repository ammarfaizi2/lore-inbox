Return-Path: <linux-kernel-owner+w=401wt.eu-S932822AbWLNPsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932822AbWLNPsV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932823AbWLNPsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:48:21 -0500
Received: from mail.tbdnetworks.com ([204.13.84.99]:55843 "EHLO
	mail.tbdnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822AbWLNPsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:48:19 -0500
X-Greylist: delayed 1337 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 10:48:19 EST
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alejandro Riveira =?ISO-8859-1?Q?Fern=E1ndez?= 
	<ariveira@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061214144750.GA4022@ucw.cz>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com>
	 <1165406299.3233.436.camel@laptopd505.fenrus.org>
	 <1165407548.5954.224.camel@titan.tbdnetworks.com>
	 <20061206131003.GF24140@stusta.de>
	 <20061209132742.7a25dcb5@localhost.localdomain>
	 <1165679105.7455.116.camel@titan.tbdnetworks.com>
	 <20061214144750.GA4022@ucw.cz>
Content-Type: text/plain
Organization: TBD Networks
Date: Thu, 14 Dec 2006 16:24:44 +0100
Message-Id: <1166109884.8815.157.camel@titan.tbdnetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 14:47 +0000, Pavel Machek wrote:
> Hi!
> 
> > So far all first-hand experiences I heard of were positive (i.e. I did
> > not get an emaail from anyone saying: It had a negative effect for me),
> > so I propose to apply the patch from Con Kolivas. The wording in the
> > description still very strongly recommends to not change that value, and
> > it's still dependent on EXPERIMENTAL. I append the patch just because
> 
> There's a big difference between 'experimental' and 'known to broke
> obscure userspace apps'.

True, but abusing EMBEDDED for "only do that if you know what you are
doing and if it breaks, you have to keep the pieces" is not good
either. 
Some other places that seem to fall into the same category are
IPX_INTERN ("...This might break existing applications...") which is
neither EMBEDDED nor EXPERIMENTAL or RMW_INSNS ("...It is very likely
that this will cause serious problems on any Amiga...") that is
dependent on ADVANCED.

Anyway, perhaps I should just select EMBEDDED although I don't have a
small system (though a 6 year old 1Ghz K7 with 1GB mem might be
considered small by some people these days :-), and ignore all the other
options that pop up through this.

Best,
  Norbert



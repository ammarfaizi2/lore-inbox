Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVBPAia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVBPAia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 19:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVBPAi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 19:38:29 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:2220 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S261180AbVBPAhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 19:37:50 -0500
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and
	give	dev=/dev/hdX as device
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Kiniger <karl.kiniger@med.ge.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       sergio@sergiomb.no-ip.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215231624.GA24023@wszip-kinigka.euro.med.ge.com>
References: <1108426832.5015.4.camel@bastov>
	 <1108434128.5491.8.camel@bastov> <42115DA2.6070500@osdl.org>
	 <1108486952.4618.10.camel@localhost.localdomain>
	 <20050215194813.GA20922@wszip-kinigka.euro.med.ge.com>
	 <1108497781.3828.51.camel@crazytrain>
	 <20050215231624.GA24023@wszip-kinigka.euro.med.ge.com>
Content-Type: text/plain
Message-Id: <1108514142.3885.1.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 15 Feb 2005 19:35:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 18:16, Kiniger wrote:

> > 
> > what about catting out that device?  I.E., 
> > 
> > 'cat /dev/cdxxx > some.iso'
> > 
> > *instead* of using 'dd' (or variants) against it?  I've always had good
> > results using 'cat' and CDs, avoiding 'dd' and CDs whenever the
> > opportunity presents itself.
> 
> I dont think this is relevant. cat will probably use stdio which will
> do blocking similar to dd (perhaps 4 kB).
> 

But it *is* a quick try (rule out), though.  Take 5 minutes if you can
and try it.  Easy to rule.  If it fails, it fails.  But *if* not, you
don't waste any more time.  I only mention it because it's worked for me
in the past where dd (and variants) has (have) not.

-fd


Return-Path: <linux-kernel-owner+w=401wt.eu-S1752734AbWLRDuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbWLRDuz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbWLRDuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:50:55 -0500
Received: from anubis.ausil.us ([216.75.14.43]:60946 "EHLO mail.ausil.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbWLRDuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:50:54 -0500
X-Greylist: delayed 1249 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 22:50:54 EST
From: Dennis Gilmore <dennis@ausil.us>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19 (current from git) on SPARC64: Can't mount /
Date: Sun, 17 Dec 2006 21:29:59 -0600
User-Agent: KMail/1.9.5
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
References: <200612131856.kBDIuk8U028993@laptop13.inf.utfsm.cl> <20061218032003.GU10316@stusta.de>
In-Reply-To: <20061218032003.GU10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612172130.00346.dennis@ausil.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time Sunday 17 December 2006 9:20 pm, Adrian Bunk wrote:
> On Wed, Dec 13, 2006 at 03:56:46PM -0300, Horst H. von Brand wrote:
> > I've been running kernel du jour straight from git on my SPARC Ultra 1
> > for some time now on Aurora Corona (Fedora relative, development branch).
> > For a few days now 2.6.19 panics on boot, it can't mount /. 2.6.19 worked
> > fine, as does 2.6.19.1 (Aurora changed gcc, mkinitrd, ... in between, so
> > I had to rebuild a kernel to check if the problem lay elsewhere).
> > Unpacking the initrds for 2.6.19 and 2.6.19.1 shows the same (nash
> > script) /init and the same modules in both (ext3 + jbd, scsi_mod, sd_mod,
> > esp, others).
> >
> > I'm stumped. Any clue?
not 100% sure here.  Check the size of the initrd.  kinda sounds like an issue 
that hit rawhide last week that needed a new mkinitrd.  if its smaller grab 
the srpm from the Fedora Development tree for mkinitrd and rebuild it.  then 
recreate your initrd and see if that works.

Dennis

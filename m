Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVFUPoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVFUPoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVFUPlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:41:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25755 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262135AbVFUPk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:40:57 -0400
Subject: Re: Bug in pcmcia-core
From: Lee Revell <rlrevell@joe-job.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42B27D51.4040407@superbug.demon.co.uk>
References: <42B1FF2A.2080608@superbug.demon.co.uk>
	 <20050617014820.GA15045@animx.eu.org>
	 <42B27D51.4040407@superbug.demon.co.uk>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 11:43:14 -0400
Message-Id: <1119368594.19357.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 08:35 +0100, James Courtier-Dutton wrote:
> > 
> > I thought drivers for the cardbus cards were the same as standard PCI cards. 
> > I know that as far as networking goes, the same driver runs a cardbus 3com
> > 3c575 and the pci 3c905.  Same with netgear's cardbus FA510 and PCI FA310.
> > 
> > I'm not a kernel developer, but this is what I've understood.
> > 
> 
> That is also what I thought. But I think that the cardbus 3com 3c575
> uses memory for io and not ioports. I think the problem is related to
> the use of ioports on an cardbus card.

Any update on this?  Is the PCMCIA layer really unmaintained?  Are we
hosed?

A quick grep of the subjects in my LKML folder for "PCMCIA" is certainly
not encouraging.  I see lots of questions along the lines of "did ANYONE
EVER get this to work?" with no replies...

Lee


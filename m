Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbTIYSDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTIYSBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:01:53 -0400
Received: from port-212-202-170-64.reverse.qdsl-home.de ([212.202.170.64]:52096
	"EHLO mail.rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S261752AbTIYSBk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:01:40 -0400
Date: Thu, 25 Sep 2003 20:01:35 +0200 (CEST)
Message-Id: <20030925.200135.607960881.rene.rebe@gmx.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmasound_pmac (2.4.x{,-benh}) does not restore mixer during
 PM-wake
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <1063262157.2023.19.camel@gaston>
References: <1063221565.678.2.camel@gaston>
	<20030910.222620.730549923.rene.rebe@gmx.net>
	<1063262157.2023.19.camel@gaston>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "idefix.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Thu, 11 Sep 2003 08:35:57 +0200, Benjamin
	Herrenschmidt <benh@kernel.crashing.org> wrote: > > > so hm?!? - is the
	wakeup order of the devices incorrect (i2c needs to > > be before
	damsound_pmac ...)? > > The i2c bus isn't suspended during sleep... I
	don't know for sure > what's up, I'll investigate. [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Thu, 11 Sep 2003 08:35:57 +0200,
    Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > so hm?!? - is the wakeup order of the devices incorrect (i2c needs to
> > be before damsound_pmac ...)?
> 
> The i2c bus isn't suspended during sleep... I don't know for sure
> what's up, I'll investigate.

Have you found some time to look into this issue in more detail? I
already tried a tiny timeout wihtout help - maybe you got an idea?

> Ben.

Sincerely yours,
  René Rebe

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de
http://gsmp.rocklinux-consulting.de/ http://gsmp.tfh-berlin.de/rene


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265370AbRFVIY4>; Fri, 22 Jun 2001 04:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265371AbRFVIYr>; Fri, 22 Jun 2001 04:24:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:46587 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265370AbRFVIYi>; Fri, 22 Jun 2001 04:24:38 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010621185144.A8669@thyrsus.com> 
In-Reply-To: <20010621185144.A8669@thyrsus.com>  <20010621154934.A6582@thyrsus.com> <Pine.LNX.4.33.0106211812560.30096-100000@xanadu.home> <20010621234002.Z18978@flint.arm.linux.org.uk> 
To: esr@thyrsus.com
Cc: Russell King <rmk@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Missing help entries in 2.4.6pre5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Jun 2001 09:24:32 +0100
Message-ID: <8226.993198272@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  I've done that in my rulesfile, thanks.  Here is the current list of
> ignored symbols:

> derive CMDLINE_BOOL from n
 ....etc...


That'll nicely break oldconfig behaviour when the options in question do 
get merged into the main tree, won't it?

Can you make them optional instead? So for normal users they're still 
_really_ undefined, and hence get asked about when they appear, rather than 
defaulting to 'n'.

--
dwmw2



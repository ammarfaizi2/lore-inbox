Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbRF2Nr3>; Fri, 29 Jun 2001 09:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbRF2NrT>; Fri, 29 Jun 2001 09:47:19 -0400
Received: from freerunner-o.cendio.se ([193.180.23.130]:39668 "EHLO
	mail.cendio.se") by vger.kernel.org with ESMTP id <S266087AbRF2NrG>;
	Fri, 29 Jun 2001 09:47:06 -0400
Date: Fri, 29 Jun 2001 15:46:07 +0200
From: Jorgen Cederlof <jc@lysator.liu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
Message-ID: <20010629154606.B24412@lola.lkpg.cendio.se>
In-Reply-To: <20010627014534.B2654@ondska> <83fdx$Z1w-B@khms.westfalen.de> <9hd7pl$86f$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9hd7pl$86f$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.19i
X-eric-conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 11:14:13 -0700, "H. Peter Anvin" wrote:
> > > If we only allow user chroots for processes that have never been
> > > chrooted before, and if the suid/sgid bits won't have any effect under
> > > the new root, it should be perfectly safe to allow any user to chroot.
> > 
> > Hmm. Dos this work with initrd and root pivoting?
> 
> At the moment, yes.  Once Viro gets his root-changes in, this breaks,
> since ALL processes will be chrooted.

What are those changes, and how will they break user chroots?

       Jörgen

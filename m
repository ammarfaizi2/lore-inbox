Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUGFXAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUGFXAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUGFXAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:00:44 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:8909 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264656AbUGFXAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:00:42 -0400
Date: Wed, 7 Jul 2004 00:54:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Gibson <hermes@gibson.dropbear.id.au>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040707005402.A15251@electric-eye.fr.zoreil.com>
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com> <20040704021304.GD25992@zax> <20040704191732.A20676@electric-eye.fr.zoreil.com> <20040706011401.A390@electric-eye.fr.zoreil.com> <40E9E6BC.8020608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40E9E6BC.8020608@pobox.com>; from jgarzik@pobox.com on Mon, Jul 05, 2004 at 07:39:40PM -0400
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> :
> Francois Romieu wrote:
> > The news:
> > - I got the adequate patch from the cvs repository
> > - 35 patches are available at the usual location. The series-mm file
> >   describes the ordering of the patches. I'll redo the numbering as
> >   it starts to be scary
> > - the remaining diff weights ~210k so far
> > 
> > At least it makes reviewing easier.
> 
> 
> If you are willing to do some re-diffing, feel free to send out the 
> boring, and easy-to-review parts such as netdev_priv() or obvious 
> cleanups.  That would help, at least, to cut things to more meat, and 
> less noise.

Actually it does not induce a noticeable noise. The remaining patch is
down to 162 ko. 50 ko have disappeared while partially moving code on
the target sources (I'll keep this part separated from the "normal"
patches).

The renumbered patches + one or two new ones are available at
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm6

--
Ueimor

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWCAOKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWCAOKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWCAOKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:10:43 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:14540 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S932170AbWCAOKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:10:42 -0500
Date: Wed, 1 Mar 2006 15:10:31 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060301141031.GC17561@boogie.lpds.sztaki.hu>
References: <20060227190150.GA9121@kroah.com> <p7364n01tv3.fsf@verdi.suse.de> <20060227194400.GB9991@suse.de> <20060301135356.GC23159@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301135356.GC23159@marowsky-bree.de>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 02:53:56PM +0100, Lars Marowsky-Bree wrote:

> The fact is that now we have user-space and kernel space tied together
> much more intimately than ever; udev & sysfs being the prime examples
> these days, and then it's not that some figure in top is wrong, but
> "oops my network no longer loads and the box is 400 miles away".

IMHO this is not a good example as there is really no reason to install
udev on such a box at all. Remember: KISS. Having a static /dev and
/etc/modules filled in (or even better, a monolithic kernel) is far more
reliable to administer.

On a desktop machine when you are plugging in various USB/Firewire/etc.
devices all the time udev works great. On a remote server there is no
real need for udev.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------

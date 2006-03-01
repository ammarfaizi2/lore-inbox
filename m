Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWCAQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWCAQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 11:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCAQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 11:30:16 -0500
Received: from gate.in-addr.de ([212.8.193.158]:45800 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751366AbWCAQaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 11:30:15 -0500
Date: Wed, 1 Mar 2006 17:30:00 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060301163000.GD9183@marowsky-bree.de>
References: <20060227190150.GA9121@kroah.com> <p7364n01tv3.fsf@verdi.suse.de> <20060227194400.GB9991@suse.de> <20060301135356.GC23159@marowsky-bree.de> <20060301141031.GC17561@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060301141031.GC17561@boogie.lpds.sztaki.hu>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-03-01T15:10:31, Gabor Gombas <gombasg@sztaki.hu> wrote:

> IMHO this is not a good example as there is really no reason to install
> udev on such a box at all. Remember: KISS. Having a static /dev and
> /etc/modules filled in (or even better, a monolithic kernel) is far more
> reliable to administer.
> 
> On a desktop machine when you are plugging in various USB/Firewire/etc.
> devices all the time udev works great. On a remote server there is no
> real need for udev.

You can't get away that easily ;-) 

First, even the enterprise distributions nowadays all use hotplug/udev
etc - for reducing the maintenance complexity, and also enterprise
systems do see a fair bit of hotplugging of new network cards, PCI
adapters, drives, or even USB attachments.

Second, sometimes my desktop is the machine I'm logging into from
remote while on the road.

The distinction isn't as clear as you think it is.


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"


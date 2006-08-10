Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWHJMgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWHJMgq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161230AbWHJMgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:36:46 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:64904 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1161228AbWHJMgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:36:45 -0400
Date: Thu, 10 Aug 2006 14:36:44 +0200
From: Gabor Gombas <gombasg@sztaki.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
Message-ID: <20060810123643.GC25187@boogie.lpds.sztaki.hu>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809221857.GG3691@stusta.de>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:18:57AM +0200, Adrian Bunk wrote:

> Real SCSI for a developer, for a user it's USB.

For a user it's a "disk" no matter what cable type (SCSI, SATA, USB,
Firewire...) is used for connecting it to the computer. You can even
connect the very same disk to the machine using either SATA/PATA, USB or
Firewire cables depending on the enclosure, so making the naming of
SATA/PATA/USB/etc. disks different is much more confusing.

AFAIR long ago Linus said he'd like just one major number (and thus only
one naming scheme) for every disk in the system; with /dev/sd* we're now
getting there.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------

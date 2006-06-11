Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWFNNxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWFNNxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWFNNxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:53:22 -0400
Received: from mailhost.terra.es ([213.4.149.12]:42733 "EHLO
	csmtpout4.frontal.correo") by vger.kernel.org with ESMTP
	id S964927AbWFNNxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:53:21 -0400
Date: Sun, 11 Jun 2006 22:14:46 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: Alex Tomas <alex@clusterfs.com>
Cc: jeff@garzik.org, alex@clusterfs.com, alan@lxorguk.ukuu.org.uk,
       chase.venters@clientec.com, torvalds@osdl.org, adilger@clusterfs.com,
       akpm@osdl.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-Id: <20060611221438.cecef685.grundig@teleline.es>
In-Reply-To: <m3wtbq5dgw.fsf@bzzz.home.net>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org>
	<448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	<m31wty9o77.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
	<1149880865.22124.70.camel@localhost.localdomain>
	<m3irna6sja.fsf@bzzz.home.net>
	<4489CB42.6020709@garzik.org>
	<m3wtbq5dgw.fsf@bzzz.home.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 09 Jun 2006 23:35:43 +0400,
Alex Tomas <alex@clusterfs.com> escribió:

> >>>>> Jeff Garzik (JG) writes:
> 
>  JG> Irrelevant.  That's a development-only situation.  It will be enabled
>  JG> by default eventually, and should be considered in that light.
> 
> that's your point of view. mine is that this option (and code)
> to be used only when needed. 


Distros may ignore your opinion and may enable it, and users won't know
that it's enabled or even if such feature exist - until they try to run
an older kernel. If almost nobody needs this feature, why not avoid
problems by not merging it and maintaining it separated from the
main tree?

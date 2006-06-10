Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030410AbWFJAlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWFJAlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030566AbWFJAlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:41:39 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:48099 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030410AbWFJAli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:41:38 -0400
Date: Fri, 9 Jun 2006 20:41:35 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Jeff Garzik <jeff@garzik.org>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <4489EC6B.4010200@garzik.org>
Message-ID: <Pine.LNX.4.64.0606092040430.17380@d.namei>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> 
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> 
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> 
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <448997FA.50109@garzik.org>
  <m3irnacohp.fsf@bzzz.home.net>  <44899A1C.7000207@garzik.org>
 <1149886363.5776.109.camel@sisko.sctweedie.blueyonder.co.uk>
 <4489EC6B.4010200@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006, Jeff Garzik wrote:

> Stephen C. Tweedie wrote:
> > Hi,
> > 
> > On Fri, 2006-06-09 at 11:56 -0400, Jeff Garzik wrote:
> > 
> > > Think about how this will be deployed in production, long term.
> > > 
> > > If extents are not made default at some point, then no one will use the
> > > feature, and it should not be merged.
> > 
> > Features such as ACLs and SELinux are still not on by default and are
> > most *definitely* used.  This is a bogus argument.
> 
> They are on in SElinux-enabled distro installs, AFAIK?

In RHEL & FC, SELinux xattrs are enabled by default, and acls need to be 
enabled via a mount option.


-- 
James Morris
<jmorris@namei.org>

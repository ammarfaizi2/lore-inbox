Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWESAFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWESAFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 20:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWESAFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 20:05:47 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:58758 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932133AbWESAFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 20:05:46 -0400
Date: Thu, 18 May 2006 20:05:44 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Matt Ayres <matta@tektonic.net>
cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
In-Reply-To: <446D0A0D.5090608@tektonic.net>
Message-ID: <Pine.LNX.4.64.0605182002330.6528@d.namei>
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>
 <44691669.4080903@tektonic.net> <Pine.LNX.4.64.0605152331140.10964@d.namei>
 <4469D84F.8080709@tektonic.net> <Pine.LNX.4.64.0605161127030.16379@d.namei>
 <446D0A0D.5090608@tektonic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006, Matt Ayres wrote:

> > I'm trying to suggest eliminating this driver & possible interaction with
> > Xen network changes as a cause.  If you can find a different type of NIC to
> > plug in and use, or even try and change all of the params for the tg3 with
> > ethtool, it'll help.
> > 
> 
> Hi,
> 
> Thank you for the assistance. Which parameters do you suggest changing?
> TSO/flow control off?

Yep, anything.

> iptables -L -v just shows 2 rules per Virtual Machine for accounting. This
> averages about 100 rules in the FORWARD chain.  Example:

Do you know if the problem starts appearing after a certain number of 
hosts?


- James
-- 
James Morris
<jmorris@namei.org>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUGFUpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUGFUpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUGFUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:44:48 -0400
Received: from 64-3-142-15.dia.xo.com ([64.3.142.15]:29701 "EHLO
	tsimail.tsearch.com") by vger.kernel.org with ESMTP id S264388AbUGFUnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:43:03 -0400
Message-ID: <828E111C7AEF60468FAA5FBC696DD80F67DF37@64-3-142-15.dia.xo.com>
From: Tim Berti <tim@tsearch.com>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] fix tcp_default_win_scale.
Date: Tue, 6 Jul 2004 13:35:56 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do i get off this list?

Tim Berti 
Senior Recruiter 
TECHNOLOGY SEARCH INTERNATIONAL 
1737 North First Street, Suite 600 
San Jose, CA. 95112 
http://www.tsearch.com 
Email: tim@tsearch.com 
Phone: 408-437-9500 Ext. 303 



-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org]
Sent: Tuesday, July 06, 2004 1:37 PM
To: David S. Miller
Cc: jamie@shareable.org; netdev@oss.sgi.com; linux-net@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.


On Tue, 6 Jul 2004 13:28:22 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Tue, 6 Jul 2004 13:05:49 -0700
> Stephen Hemminger <shemminger@osdl.org> wrote:
> 
> > On Tue, 6 Jul 2004 20:40:34 +0100
> > Jamie Lokier <jamie@shareable.org> wrote:
> > 
> > > Are you saying there are broken firewalls which strip TCP options in
> > > one direction only?
> > 
> > It appears so.
> 
> Ok, this is a possibility.  And why it breaks is that if the ACK
> for the SYN+ACK comes back, the SYN+ACK sender can only assume
> that the window scale was accepted.
> 
> Stephen, do you have a trace showing exactly this?

No, I don't have a br0ken firewall here.  I can get out fine.
When I setup with same kernel as packages.gentoo.org, it works fine as well.

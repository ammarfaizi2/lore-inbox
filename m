Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271194AbTGWSIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271196AbTGWSIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:08:01 -0400
Received: from rth.ninka.net ([216.101.162.244]:35713 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S271194AbTGWSH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:07:58 -0400
Date: Wed, 23 Jul 2003 11:22:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICMP REQUEST
Message-Id: <20030723112229.4b4903ed.davem@redhat.com>
In-Reply-To: <20030723181212.GB15719@pegasys.ws>
References: <E04CF3F88ACBD5119EFE00508BBB212104BCD649@exch-01.noida.hcltech.com>
	<20030723181212.GB15719@pegasys.ws>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 11:12:12 -0700
jw schultz <jw@pegasys.ws> wrote:

> On Wed, Jul 23, 2003 at 12:53:35PM +0530, Hemanshu Kanji Bhadra, Noida wrote:
> > Hi, All
> > 
> > i am developing a  ping program, through my program I get ECHO_REPLY..but I
> > dont get ECHO_REQUEST.
> > 
> > is that the ECHO_REQUEST is handled by kernel.?
> > 
> > please respond as it is urgent.
> 
> In most cases ICMP ECHO_REQUEST is handled by the NIC.  The
> kernel doesn't even see it.  That is why you can ping a
> crashed system; the NIC is still configured.

False.

The reason you can ping a crashed system is that the network
stack and the card are still functioning in the kernel.

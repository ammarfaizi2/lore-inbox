Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUCJTmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbUCJTmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:42:52 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:16137 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262792AbUCJTmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:42:43 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@suse.de>, Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: ip a flush problem on 2.6 kernels (fine on 2.4 kernels)
Date: Wed, 10 Mar 2004 21:37:40 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200403040308.15880.arekm@pld-linux.org> <20040304141319.2d1cb112.ak@suse.de>
In-Reply-To: <20040304141319.2d1cb112.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403102137.40073.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 March 2004 15:13, Andi Kleen wrote:
> On Thu, 4 Mar 2004 03:08:15 +0100
>
> Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:
> > The problem is that
> >
> > ip a a 192.168.0.1/24 dev eth0
> > ip link set eth0 down
> > ip a flush dev eth0
> >
> > Here on my vanilla 2.6.2 it locks eating CPU - it does netlink
> > communication over and over. This ,,hang'' doesn't happen when
> > interface is in UP state. Also doesn't happen on 2.4 kernels.
>
> I fixed it with this patch for iproute2 here. It's not clear to me at
> all how it ever worked before. The loop seems to be just wrong.

Does iproute2 have a homepage again? Where?
--
vda


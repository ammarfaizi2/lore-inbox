Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVARQzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVARQzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVARQzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:55:50 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:53771 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP id S261350AbVARQzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:55:42 -0500
From: "Udo van den Heuvel" <udovdh@xs4all.nl>
To: "'Luc Saillard'" <luc@saillard.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: VIA Rhine ethernet driver bug
Date: Tue, 18 Jan 2005 17:55:34 +0100
Message-ID: <000701c4fd7e$874a5a00$450aa8c0@hierzo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <20050117154540.GA2642@sd291.sivit.org>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> -----Original Message-----
> From: Luc Saillard [mailto:luc@saillard.org] 
> Sent: maandag 17 januari 2005 16:46
> To: Marcelo Tosatti
> Cc: Udo van den Heuvel; linux-kernel@vger.kernel.org
> Subject: Re: VIA Rhine ethernet driver bug
> 
> 
> On Mon, Jan 17, 2005 at 10:04:27AM -0200, Marcelo Tosatti wrote:
> > On Sat, Jan 15, 2005 at 12:43:33PM +0100, Udo van den Heuvel wrote:
> 
> > > On my firewall (VIA EPIA CL-6000 with VIA Rhine network 
> chips running FC3
> > > and custom kernels) I see messages like:
> > 
> > What kernel version are you using? Its important to inform that.

Problem is in all kernel versions since 1999 or so.
I am at 2.6.10-mm2, experimented with older via-rhince.c drivers.


> It's not a critical bug, but if we can resolv the bug ...

If it drops the link with the net I do think it IS critical.
Most of the time occurences of this bug do make my pppd choke.

ifconfig eth1 down
ifconfig eth1 up

helps.


How can we nail the cause? Fix the bug partly or completely?
Suggestions are very welcome.

Thanks,
Udo



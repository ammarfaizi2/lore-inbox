Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265015AbUD2Wra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbUD2Wra (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbUD2Wra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:47:30 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28684 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265015AbUD2Wr3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:47:29 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Kenneth =?iso-8859-1?q?Aafl=F8y?= <keaafloy@online.no>,
       Ian Stirling <ian.stirling@mauve.plus.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 01:47:13 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40906A35.3090004@mauve.plus.com> <200404290447.30154.keaafloy@online.no>
In-Reply-To: <200404290447.30154.keaafloy@online.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404300147.13816.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 April 2004 05:47, Kenneth Aafløy wrote:
> On Thursday 29 April 2004 04:36, you wrote:
> > Marc Boucher wrote:
> > > Hi Rik,
> > >
> > > Your new proposed message sounds much clearer to the ordinary mortal
> > > and would imho be a significant improvement. Perhaps printing
> > > repetitive warnings for identical $MODULE_VENDOR strings could also be
> > > avoided, taking care of the redundancy/volume problem as well..
> >
> > Is this worth 100 or 200 bytes of code though?
> > I'd have to say no.
>
> 1000-2000(?) instructions to display the message and some x(?) instructions

No. ~20 bytes or less on x86 (push,call printk() isns).
Plus text of the message (~150 bytes?).
If you're talking about *time* to execute 2000 insns, that
too does not make much sense.
--
vda


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWGFTC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWGFTC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWGFTC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:02:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62679 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750712AbWGFTC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:02:57 -0400
Subject: Re: lockdep input layer warnings.
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dave Jones <davej@redhat.com>, mingo@redhat.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
References: <20060706173411.GA2538@redhat.com>
	 <d120d5000607061137r605a08f9ie6cd45a389285c4a@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 21:02:55 +0200
Message-Id: <1152212575.3084.88.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 14:37 -0400, Dmitry Torokhov wrote:
> On 7/6/06, Dave Jones <davej@redhat.com> wrote:
> > One of our Fedora-devel users picked up on this this morning
> > in an 18rc1 based kernel.
> >
> >                Dave
> >
> >
> >  Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
> >  serio: Synaptics pass-through port at isa0060/serio1/input0
> >  input: SynPS/2 Synaptics TouchPad as /class/input/input1
> >  PM: Adding info for serio:serio2
> >
> >  =============================================
> >  [ INFO: possible recursive locking detected ]
> >  ---------------------------------------------
> 
> False alarm, there was a lockdep annotating patch for it in -mm.
not so sure; that patch is supposed to be in -rc1 already; investigating


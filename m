Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284807AbSABV24>; Wed, 2 Jan 2002 16:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbSABV07>; Wed, 2 Jan 2002 16:26:59 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:4073 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S284304AbSABV02>; Wed, 2 Jan 2002 16:26:28 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: "ChristianK."@t-online.de (Christian Koenig)
To: esr@thyrsus.com, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Date: Wed, 2 Jan 2002 22:28:04 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020102151539.A14925@thyrsus.com>
In-Reply-To: <20020102151539.A14925@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <16Lstn-0eAVxAC@fwd07.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 02 January 2002 21:15, Eric S. Raymond wrote:
> Is there any way to safely probe a PCI motherboard to determine whether
> or not it has ISA cards present, or ISA card slots?
>
> Note: the question is *not* about a probe for whether the board has an ISA
> bridge, but a probe for the presence of actual ISA cards (or slots).
>
> (Yes, I'm working on a smart autoconfigurator.  It's a development of
> Giacomo Catenazzi's code, but able to use the CML2 deduction engine.)

Nope, AFAIK even if the motherboard dosn't have ISA-Slots, the ISA-like 
chipset (DMA/old IRQ/Timer) is still present because off compatiblity reasons.

But if you only want to know if a specified IO-range is on an ISA-card you 
could try to turn off the PCI-ISA brige, done this with Intel chipset before 
(they call this power saveing mode).

MfG, Christian König.

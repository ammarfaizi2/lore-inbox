Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271787AbRIVQHx>; Sat, 22 Sep 2001 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIVQHn>; Sat, 22 Sep 2001 12:07:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43020 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271787AbRIVQH0>; Sat, 22 Sep 2001 12:07:26 -0400
Subject: Re: [Newbie] Interrupt Handling and sleep/wake_up
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sat, 22 Sep 2001 17:12:41 +0100 (BST)
Cc: chris@obelix.hedonism.cx (Christian Vogel), linux-kernel@vger.kernel.org
In-Reply-To: <3BAC8385.BFA35D19@colorfullife.com> from "Manfred Spraul" at Sep 22, 2001 02:26:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kpOT-0003bC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> check the mouse driver sample from Alan Cox:
> 	linux/Documentation/DocBook/mousedriver.tmpl
> 
> The document is slightly outdated:
> 
> * do not access current->state directly, use set_current_state.
> * do not use MOD_INC_USE_COUNT, set module->owner to THIS_MODULE
> instead.

Thanks: Updated

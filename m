Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133007AbRD3SNJ>; Mon, 30 Apr 2001 14:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133024AbRD3SM6>; Mon, 30 Apr 2001 14:12:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16649 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133007AbRD3SMx>; Mon, 30 Apr 2001 14:12:53 -0400
Subject: Re: 2.4 and 2GB swap partition limit
To: jamagallon@able.es (J . A . Magallon)
Date: Mon, 30 Apr 2001 19:12:12 +0100 (BST)
Cc: R.E.Wolff@BitWizard.nl (Rogier Wolff), wakko@animx.eu.org (Wakko Warner),
        xavier.bestel@free.fr (Xavier Bestel),
        goswin.brederlow@student.uni-tuebingen.de (Goswin Brederlow),
        fluffy@snurgle.org (William T Wilson), Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010428162803.C1062@werewolf.able.es> from "J . A . Magallon" at Apr 28, 2001 04:28:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uI9f-0008Kt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> paging in just released 2.4.4, but in previuos kernel, a page that was
> paged-out, reserves its place in swap even if it is paged-in again, so
> once you have paged-out all your ram at least once, you can't get any
> more memory, even if swap is 'empty'.

This is a bug in the 2.4 VM, nothing more or less. It and the horrible bounce
buffer bugs are forcing large machines to remain on 2.2. So it has to get 
fixed


Alan


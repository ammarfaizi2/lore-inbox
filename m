Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbRGFLOR>; Fri, 6 Jul 2001 07:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266385AbRGFLOH>; Fri, 6 Jul 2001 07:14:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28433 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266384AbRGFLN7>; Fri, 6 Jul 2001 07:13:59 -0400
Subject: Re: [PATCH] Updates to Maestro{1,2,2E} driver -- multiple open of dsp, persistent buffers.
To: daniel@rimspace.net (Daniel Pittman)
Date: Fri, 6 Jul 2001 12:14:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87u20qa03r.fsf@inanna.rimspace.net> from "Daniel Pittman" at Jul 06, 2001 07:16:40 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ITYs-0004EU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch has the blessing of Zach Brown, the current maintainer, as far
> as that goes -- but it's my own work. :)

You need to keep the dsp_order option as people have stuff relying on it
(at least for 2.4). It doesnt need to be documented or the recommended way
(and I agree its a bit strange) but it needs to work


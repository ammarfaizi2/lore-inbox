Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262507AbRENV3c>; Mon, 14 May 2001 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbRENV3W>; Mon, 14 May 2001 17:29:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6410 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262505AbRENV3N>; Mon, 14 May 2001 17:29:13 -0400
Subject: Re: TCP capture effect (was Re: Linux TCP impotency)
To: meder@mcs.anl.gov (Samuel Meder)
Date: Mon, 14 May 2001 22:25:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010514161509.B3192@titan.mcs.anl.gov> from "Samuel Meder" at May 14, 2001 04:15:12 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zPqN-0001Si-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm curious about this effect so I've been trying to find information
> on this and while I can find lots of information on the Ethernet
> capture effect there doesn't seem to be anything on the TCP capture
> effect. Could someone point me at an explanation of this effect?

it is exactly the same thing but the backoffs are the TCP level backoffs and
the collisions are between TCP streams. There are statistical approaches to
fairness used in routers (a local capture effect annoyance to you
is rather bad news on backbones).

Alan

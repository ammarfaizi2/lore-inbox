Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUJNNpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUJNNpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUJNNpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:45:52 -0400
Received: from serv1.obs-besancon.fr ([193.52.185.11]:54789 "EHLO
	serv1.obs-besancon.fr") by vger.kernel.org with ESMTP
	id S264704AbUJNNpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:45:50 -0400
Date: Thu, 14 Oct 2004 13:44:41 +0000 (UTC)
From: Francois Meyer <fmeyer@obs-besancon.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Clock inaccuracy seen on NVIDIA nForce2 systems.
Message-ID: <Pine.LNX.4.44.0410140745570.9705-100000@jupiter.obs-besancon.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean, Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The system is running 2.6.9-rc4 and has been up for 2 days. I'm showing
> an offset of -32 seconds and growing.

As it has been said, this could be  due  to  just  a
poor quality crystal. In addition, non  temperature-
controlled  crystals  are  far  more  efficient   as
thermometers than as oscillators,  as  frequency  is
directly and more than  significantly  depending  on
crystal temperature.

Now if you think there  is  a  real  software  issue
behind your observations, it wont be  that  easy  to
distinguish between crystal and soft  contributions,
unless the specifications of  the  crystal  used  on
those boards are far better than the  drifts  you
observed.

If the specs are of the same order, I think reliable
conclusions can only arise from tests issued on  the
same physical hardware.

-- Francois Meyer



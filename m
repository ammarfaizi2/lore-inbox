Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbTAVLBM>; Wed, 22 Jan 2003 06:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbTAVLBL>; Wed, 22 Jan 2003 06:01:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:55736 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267435AbTAVLBL>;
	Wed, 22 Jan 2003 06:01:11 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 22 Jan 2003 12:10:17 +0100 (MET)
Message-Id: <UTC200301221110.h0MBAHL28375.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, mzyngier@freesurf.fr
Subject: Re: 3c509.c
Cc: ALESSANDRO.SUARDI@oracle.com, efault@gmx.de, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Marc Zyngier <mzyngier@freesurf.fr>

    Andries> This evening the next attempt. Under 2.5.58 my ethernet cards
    Andries> still work, under 2.5.59 eth0, a 3c509, fails.

    I'm the guilty one for (1) and (2). These problems are coming from the
    3c509 removal from Space.c.

    I'll cook a patch latter today...

I forgot to mention the conclusion of (3): inserting code
in the Boomerang driver to print ethN and MAC address
made immediately clear what happened: eth0 and eth1 had
been interchanged.

Andries

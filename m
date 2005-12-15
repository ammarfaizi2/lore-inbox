Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbVLOUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbVLOUiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVLOUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:38:52 -0500
Received: from khc.piap.pl ([195.187.100.11]:16644 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751058AbVLOUiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:38:51 -0500
To: Dave Jones <davej@codemonkey.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: agpgart.ko can't be unloaded
References: <m3acf2i05d.fsf@defiant.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 15 Dec 2005 21:38:49 +0100
In-Reply-To: <m3acf2i05d.fsf@defiant.localdomain> (Krzysztof Halasa's
 message of "Thu, 15 Dec 2005 21:19:10 +0100")
Message-ID: <m31x0ehz8m.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recently noticed that agpgart.ko (and corresponding hardware driver)
> can't be unloaded:
>
> Module                  Size  Used by
> intel_agp              19228  1 
> agpgart                27592  1 intel_agp

BTW: "rmmod -w agpgart intel_agp" hangs in uninterruptible sleep state
("D") forever.

This is i386 (Athlon XP to be precise), FC4-current, 2.6.14.
-- 
Krzysztof Halasa

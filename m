Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWBFLPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWBFLPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWBFLPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:15:10 -0500
Received: from khc.piap.pl ([195.187.100.11]:12299 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750742AbWBFLPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:15:08 -0500
To: Neil Brown <neilb@suse.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
	<787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
	<Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
	<20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner>
	<"787b0d920602 <Pine.LNX.4.61.0602050838110.6749"@yvahk01.tjqt.qr>
	<43E62492.6080506@cfl.rr.com>
	<E4D853FC-34C1-4332-BF92-D90E059D7543@mac.com>
	<17382.31725.813127.10435@cse.unsw.edu.au>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 06 Feb 2006 12:15:05 +0100
In-Reply-To: <17382.31725.813127.10435@cse.unsw.edu.au> (Neil Brown's message of "Mon, 6 Feb 2006 09:27:57 +1100")
Message-ID: <m3bqxkivra.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> writes:

> Bit on open without O_EXCL will always succeed no matter whether
> someone has it O_EXCL or not.

Ok. That means hald has no use for it, but cdrecord and similar
programs could use it.
-- 
Krzysztof Halasa

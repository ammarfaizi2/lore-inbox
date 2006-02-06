Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWBFO6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWBFO6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWBFO6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:58:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37823 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932144AbWBFO6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:58:53 -0500
Date: Mon, 6 Feb 2006 15:58:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Neil Brown <neilb@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       Phillip Susi <psusi@cfl.rr.com>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <m3bqxkivra.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.61.0602061557240.31522@yvahk01.tjqt.qr>
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo>
 <43E27792.nail54V1B1B3Z@burner> <"787b0d920602 <Pine.LNX.4.61.0602050838110.6749"@yvahk01.tjqt.qr>
 <43E62492.6080506@cfl.rr.com> <E4D853FC-34C1-4332-BF92-D90E059D7543@mac.com>
 <17382.31725.813127.10435@cse.unsw.edu.au> <m3bqxkivra.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> Bit on open without O_EXCL will always succeed no matter whether
>> someone has it O_EXCL or not.
>
>Ok. That means hald has no use for it, but cdrecord and similar
>programs could use it.

But that again sounds like hald won't use O_EXCL, therefore could always be 
able to open the device and potentially send commands which interrupt cd 
writing.


Jan Engelhardt
-- 

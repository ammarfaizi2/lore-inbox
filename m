Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWBEVQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWBEVQB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 16:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWBEVQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 16:16:01 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59102 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750730AbWBEVQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 16:16:00 -0500
Date: Sun, 5 Feb 2006 22:15:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Phillip Susi <psusi@cfl.rr.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <E4D853FC-34C1-4332-BF92-D90E059D7543@mac.com>
Message-ID: <Pine.LNX.4.61.0602052215190.330@yvahk01.tjqt.qr>
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo>
 <43E27792.nail54V1B1B3Z@burner> <"787b0d920602 <Pine.LNX.4.61.0602050838110.6749"@yvahk01.tjqt.qr>
 <43E62492.6080506@cfl.rr.com> <E4D853FC-34C1-4332-BF92-D90E059D7543@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> If you specify O_EXCL (and not O_CREAT), it is implementation defined what will
> happen (in the Linux case, this opens a block device for exclusive access).
>
And with plain files, I supose it's free-for-all, right? 'Cause that's what 
my testcase yielded. :/


Jan Engelhardt
-- 

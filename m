Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWBIQJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWBIQJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWBIQJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:09:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35043 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932512AbWBIQJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:09:29 -0500
Date: Thu, 9 Feb 2006 17:09:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, Neil Brown <neilb@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43E7977A.1010509@cfl.rr.com>
Message-ID: <Pine.LNX.4.61.0602091708340.30108@yvahk01.tjqt.qr>
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo>
 <43E27792.nail54V1B1B3Z@burner> <"787b0d92060 <m3lkwogxmc.fsf@defiant.localdomain>
 <43E7977A.1010509@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Out of curiosity, what commands does hal send the drive that can interrupt
> burning?  I've been reading the MMC-5 standard lately and it looks like while
> the drive is burning, attempts to send it other commands that would interfere
> with the burn are supposed to be failed with an error code indicating that a
> burn is in progress, and thus, avoid making a coaster. 
>
At least there needs to be a command that is not ignored to stop a burn.
Though, hald would not be /that/ evil.


Jan Engelhardt
-- 

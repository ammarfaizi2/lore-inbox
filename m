Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945992AbWBOPo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945992AbWBOPo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbWBOPo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:44:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15854 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1945992AbWBOPo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:44:58 -0500
Date: Wed, 15 Feb 2006 16:44:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, davidsen@tmr.com,
       nix@esperi.org.uk, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060213154921.GA22597@kroah.com>
Message-ID: <Pine.LNX.4.61.0602151643470.25885@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
 <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>
 <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>
 <43F0891E.nailKUSCGC52G@burner> <20060213154921.GA22597@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Of course not.  Here's one line of bash that gets you the major:minor
>file of every block device in the system:
>	block_devices="$(echo /sys/block/*/dev /sys/block/*/*/dev)"
>
When was that added? /sys/block/hdc/device/ only has "power", "block", 
"bus" and "driver" here on a 2.6.13-rc3.


Jan Engelhardt
-- 

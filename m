Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWBQPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWBQPpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWBQPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:45:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:49110 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750705AbWBQPpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:45:22 -0500
Date: Fri, 17 Feb 2006 16:45:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: dhazelton@enter.net, matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43F5B686.nail2VCA2A2OF@burner>
Message-ID: <Pine.LNX.4.61.0602171643560.27452@yvahk01.tjqt.qr>
References: <43EB7BBA.nailIFG412CGY@burner> <20060216115204.GA8713@merlin.emma.line.org>
 <43F4BF26.nail2KA210T4X@burner> <200602161742.26419.dhazelton@enter.net>
 <43F5B686.nail2VCA2A2OF@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Of the two bugs you've reported, one only exists in a deprecated and soon to 
>> be removed module. I will try to fix the other one as soon as you can provide 
>> me with enough data that I can see exactly what is getting messed up where.
>
>Sorry, the way to access SCSI generic via /dev/hd* is deprecated. If ide-scsi
>ir removed, then a clean and orthogonal way of accessing SCSI in a generic
>way is removed from Linux. If Linux does nto care about orthogonality of 
>interfaces, this is a problem of the people who are responbile for the related
>interfaces.
>

So what you want is to be able to use write() on a <sg-compatible> device 
rather than doing SG_IO ioctl() on <any> device?


Jan Engelhardt
-- 

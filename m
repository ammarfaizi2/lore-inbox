Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbULHO2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbULHO2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbULHO2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:28:20 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:8305 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261227AbULHO2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:28:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=FWkV9EEPVf1ieO9hIlYjTy4zO9Jz4mmdf6KPetSufUsfU+s2gAc14q4rlSputrhnNQkrm0HfW7O4npdeQ8XG8ckPNP4r28sSsBnvpinxmhTVRXcmrk9zN6zHfznTdFfBh1PIsieMuzimHDMZGL52CvBb9ZYqEy4yGUNMCDmUFO4=
Message-ID: <a63d67fe0412071059323f0900@mail.gmail.com>
Date: Tue, 7 Dec 2004 10:59:14 -0800
From: Dan Carpenter <error27@gmail.com>
Reply-To: Dan Carpenter <error27@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: aacraid drops offline w/ opteron and 16G of RAM (2.6.9)
Cc: linux-scsi@vger.kernel.org, dackerman@penguincomputing.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using an Adaptec 2200S RAID card in an opteron system.  It works fine 
if I use 12G of RAM but if I have 16G it drops offline under stress (bonnie++ 
etc).  Basically it's as if the whole array has been removed.

I first saw this problem under the suse9.1 2.6.5 kernel but the
problem is still
there under the 2.6.9 kernel as well.

I've tested the hardware, and this has happenned on 2 seperate systems so
it's not a hardware component problem.

Based on history with different RAID cards, I tried turning off node interleave
and harddware IOMMU on the Arima motherboard, but that hasn't made a 
difference.

Has anyone seen this problem before?

regards,
dan carpenter

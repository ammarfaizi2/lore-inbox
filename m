Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSE3QmY>; Thu, 30 May 2002 12:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSE3QmX>; Thu, 30 May 2002 12:42:23 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:62983 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S316753AbSE3QmX>; Thu, 30 May 2002 12:42:23 -0400
Message-Id: <200205301639.g4UGdS916620@aslan.scsiguy.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic-6.2.8 with U160 drives 
In-Reply-To: Your message of "Thu, 30 May 2002 15:25:01 +0200."
             <20020530132501.GA18235@werewolf.able.es> 
Date: Thu, 30 May 2002 10:39:28 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have noticed a problem with the recent update in 2.4.19-pre9.
>I have an Adaptec 29160 card, and a couple scsi4 Fujitsu drives,
>that with previous -pre version worked at 160, AFAIR.
>With the recent update, they slow down to 40Mb/s. I will recheck
>bios settings, but...

Are you sure you don't have a single ended device on the same
bus segment as the fujitsu drives?  It looks like the driver is
running the bus in SE mode.

--
Justin

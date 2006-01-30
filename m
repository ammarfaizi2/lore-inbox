Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWA3Kqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWA3Kqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWA3Kqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:46:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3797 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932208AbWA3Kqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:46:33 -0500
Date: Mon, 30 Jan 2006 11:46:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing filesystem
In-Reply-To: <1138617550.2977.24.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0601301144380.12961@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local>  <200601231257.28796@bilbo.math.uni-mannheim.de>
  <87mzhgyomh.fsf@goat.bogus.local> <20060128150137.5ba5af04.akpm@osdl.org>
  <Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>  <20060130011630.60f402d8.akpm@osdl.org>
  <Pine.LNX.4.61.0601301024150.6405@yvahk01.tjqt.qr> 
 <1138614388.2977.10.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0601301050260.6405@yvahk01.tjqt.qr> 
 <1138614856.2977.16.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0601301114160.25336@yvahk01.tjqt.qr> 
 <1138617073.2977.21.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0601301135540.12495@yvahk01.tjqt.qr>
 <1138617550.2977.24.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hm, is it allowed to call copy_{from,to}_user() in irq context?
>
>absolutely not.

Right, everything clarified then. Remove the semaphores ;)



Jan Engelhardt
-- 

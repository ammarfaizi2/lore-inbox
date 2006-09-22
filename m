Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWIVUfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWIVUfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWIVUfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:35:09 -0400
Received: from ftpbox.mot.com ([129.188.136.9]:51911 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S964893AbWIVUfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:35:07 -0400
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Fri, 22 Sep 2006 15:34:50 -0500 (CDT)
Message-Id: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: pavel@ucw.cz
CC: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-reply-to: Pavel Machek's message of Fri, 22 Sep 2006 16:11:27 +0200
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note that I don't think PowerOp would cover all devices. In fact, I
think most devices would remain autonomous or controlled as part of
specific subsystems. The only things that PowerOp would bundle together
would be things that aren't independent (and may not even be visible as
"devices" in the usual Linux sense), but that have to be managed
together in changing frequency/voltage. At least, that's the way I
imagined it would work.

scott


| From pavel@ucw.cz Fri Sep 22 09:13:53 2006
| 
| Hi!
| 
| > Hmm. If you assume the CPUs in an SMP system can be in different
| > operating points, this would (as Pavel pointed out) result in an
| > explosion of operating points.
| 
| Problem is not only CPUs, devices are mostly independent in PC
| case... it would be nice to solve that problem with same approach.
| 
| 								Pavel
| -- 
| (english) http://www.livejournal.com/~pavelmachek
| (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
| 

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



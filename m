Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbTFQOpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264784AbTFQOo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:44:59 -0400
Received: from speedy.tutby.com ([195.209.41.194]:39594 "EHLO tut.by")
	by vger.kernel.org with ESMTP id S264761AbTFQOoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:44:12 -0400
Date: Tue, 17 Jun 2003 17:59:47 +0300
From: Igor Krasnoselski <iek@tut.by>
X-Mailer: The Bat! (v1.36) S/N F29DEE5D / Educational
Reply-To: Igor Krasnoselski <iek@tut.by>
X-Priority: 3 (Normal)
Message-ID: <0749.030617@tut.by>
To: Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
Subject: Re[4]: Can't mount an ext3 partition - why?
In-reply-To: <20030617143746.GA16057@www.13thfloor.at>
References: <20030617143746.GA16057@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Herbert,

HP> this is typical devfs without devfsd config
HP> to establish the 'old' 'compatible' device names

HP> either you remove devfs, or disable it at boot
HP> (devfs=nomount as far as I recall) or configure/
HP> install devfsd to generate the old-compatibility
HP> links ...

HP> or you change all your device references to
HP> the 'new' style, /dev/discs/disc0/...

HP> hth,
HP> Herbert

Thank you! You and Chris Meadors help me very much. I'll find out more
info about devfs and then maybe use it in my kernel... For now, I'll
simply exclude it off.

-- 
Best regards,
 Igor                            mailto:iek@tut.by
                                 mailto:u-com@mail.ru



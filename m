Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbUC2MG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbUC2MG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:06:57 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:59911 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S262125AbUC2MGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:06:54 -0500
Message-ID: <1080562094.406811ae99af0@imp.gcu.info>
Date: Mon, 29 Mar 2004 14:08:14 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Lucas de Souza Santos <lucasdss@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Isa/i2c [bug report]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

> i'm running 2.6.5-rc2-bk7 and i'm having some problems with sensors
> and my sound blaster ISA-awe 64. With 2.6.4 everything is working,
> but in 2.6.5.rc2-bk7 my isa cards (sb-awe64 and sym53c416) are in
> conflict and sensors of my motherboard stop to work.

The sysfs interface to hardware monitoring chips changed between kernels
2.6.4 and 2.6.5. The user-space tools and library had to be updated
accordingly. You may simply need to get lm_sensors CVS to get your
sensors work again.

> I have to disable my sym53c416 (isa-scsi card) for my sound work, but
> with 2.6.4 its work fine together.

Could you please compile your kernel without i2c support and confirm
that the problem is still there? Just to make sure it's unrelated.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/


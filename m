Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274980AbRIYMRB>; Tue, 25 Sep 2001 08:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274981AbRIYMQv>; Tue, 25 Sep 2001 08:16:51 -0400
Received: from smtp3.libero.it ([193.70.192.53]:52435 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S274980AbRIYMQs>;
	Tue, 25 Sep 2001 08:16:48 -0400
Subject: Re: Burning a CD image slow down my connection
From: "[A]ndy80" <andy80@ptlug.org>
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.A32.3.95.1010925121523.20872B-100000@werner.exp-math.uni-essen.de>
In-Reply-To: <Pine.A32.3.95.1010925121523.20872B-100000@werner.exp-math.uni-essen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.24.08.08 (Preview Release)
Date: 25 Sep 2001 14:24:54 +0200
Message-Id: <1001420696.1316.8.camel@piccoli>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> Hmm, /dev/cdrom would typically be a link. You might try to apply hdparm
> to where the link points to, but I cannot really believe hdparm doesn't
> follow links.

yes it's a link to /dev/scd0 and I CAN mount it, because my IDE cdrom is
seen as scsi. In lilo.conf I've this line: append="hdd=ide-scsi
hdc=ide-scsi" (read CD-WRITING HOWTO for more information)



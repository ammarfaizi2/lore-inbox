Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSGNRgj>; Sun, 14 Jul 2002 13:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSGNRgi>; Sun, 14 Jul 2002 13:36:38 -0400
Received: from descartes.noos.net ([212.198.2.74]:10587 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S316969AbSGNRgh>;
	Sun, 14 Jul 2002 13:36:37 -0400
Message-ID: <3D31B748.9070808@free.fr>
Date: Sun, 14 Jul 2002 19:39:20 +0200
From: Christian Gennerat <xgen@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: fr-fr
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: hda: lost interrupt
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this line in my /etc/rc.d/rc.local
hdparm -c 1 -m 16 -S 6 /dev/hda

with 2.4.18 kernel it works fine.
with 2.5.25 I get "hda: lost interrupt" 30 seconds after.
And reset, and fsck... every time

What is new in 2.5.25 ?


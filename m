Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLGAg3>; Wed, 6 Dec 2000 19:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLGAgT>; Wed, 6 Dec 2000 19:36:19 -0500
Received: from jalon.able.es ([212.97.163.2]:53464 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129406AbQLGAgN>;
	Wed, 6 Dec 2000 19:36:13 -0500
Date: Thu, 7 Dec 2000 01:05:37 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: poll() blocking
Message-ID: <20001207010537.A1611@werewolf.able.es>
Reply-To: jamagallon@able.es
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw some time ago some discussion about poll(). This is may question
(if it remembers anyone a known issue):

A driver poll_wait()s hardware and wants to raise an interrupt on hardware
change.

It works on 2.2 SMP but locks in 2.4 SMP. Works on 2.4 UP.

Is any SMP issue with poll ?

Thanks.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux 2.2.18-pre24-vm #2 SMP Wed Nov 29 02:56:21 CET 2000 i686 unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

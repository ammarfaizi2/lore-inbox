Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278172AbRJLWLK>; Fri, 12 Oct 2001 18:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278173AbRJLWLA>; Fri, 12 Oct 2001 18:11:00 -0400
Received: from jalon.able.es ([212.97.163.2]:10882 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S278172AbRJLWKv>;
	Fri, 12 Oct 2001 18:10:51 -0400
Date: Sat, 13 Oct 2001 00:11:16 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: bug in mips/config.in
Message-ID: <20011013001116.G1693@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Due to a buggy bit I found in i2c, I did a
werewolf:/usr/src/linux# grep -r "\"CONFIG" . | fgrep .in
./arch/mips/config.in:      if [ "CONFIG_DECSTATION" = "y" ]; then

'$' is missing there, isn't it ?
Is there any similar buglet to check ?

By

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-pre1-beo #1 SMP Fri Oct 12 11:32:03 CEST 2001 i686

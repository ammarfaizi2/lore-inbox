Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318278AbSHNNmK>; Wed, 14 Aug 2002 09:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318301AbSHNNmK>; Wed, 14 Aug 2002 09:42:10 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:39365 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S318278AbSHNNmJ> convert rfc822-to-8bit;
	Wed, 14 Aug 2002 09:42:09 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: "Ph. Marek" <marek@bmlv.gv.at>
To: linux@syskonnect.de
Subject: /proc/net/sk98lin directory more than once in ls
Date: Wed, 14 Aug 2002 15:46:18 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208141546.18805.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm using linux-2.4.19pre1 on x86/SMP and I believe I found a bug in the 
sk98lin driver.
It shows by unloading and loading the module sk98lin - then one more directory 
entry "/proc/net/sk98lin" is created. I tested this with up to 4 directories.

I think this is a bug in the unregister function of your driver.

Thank you for your patience.


Regards,

Ph. Marek


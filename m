Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292222AbSBTTM5>; Wed, 20 Feb 2002 14:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292216AbSBTTMh>; Wed, 20 Feb 2002 14:12:37 -0500
Received: from fw.aub.dk ([195.24.1.194]:8320 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S292217AbSBTTM2>;
	Wed, 20 Feb 2002 14:12:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Idiot-proof APIC?
Date: Wed, 20 Feb 2002 20:07:47 +0100
X-Mailer: KMail [version 1.3.2]
X-BeenThere: crackmonkey@crackmonkey.org
X-Fnord: +++ath
X-Message-Flag: Message text blocked
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16dc5j-0000CB-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I just want to share some of my stupidity and my experience with it with 
you. 
I recently had the misfortune to try to put two celerons on an SMP-board. The 
bios correctly ignored the second cpu, but the linux-kernel(2.4.17). Would 
boot almost normally then emit two APIC-errors to the console(error 2 and 
6?), and shortly after freeze completely. After one of the celerons was 
removed linux was completely stable. Something inside makes me question 
whether or not the APIC people have taken idiots into consideration. The 
kernel should detect two cpu, detect they are not SMP and then operate using 
just one. Not very importent, but correct behavior.
Anyway for specs the board it was an Acorp 6A815EPD. Proberbly the one of the 
only SMP i815 mortherboards in the world.

-Allan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271646AbRHQNKS>; Fri, 17 Aug 2001 09:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271648AbRHQNKI>; Fri, 17 Aug 2001 09:10:08 -0400
Received: from lambik.cc.kuleuven.ac.be ([134.58.10.1]:35086 "EHLO
	lambik.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S271646AbRHQNKD>; Fri, 17 Aug 2001 09:10:03 -0400
Message-Id: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be>
Content-Type: text/plain; charset=US-ASCII
From: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8/2.4.9 VM problems
Date: Fri, 17 Aug 2001 15:10:15 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since i upgraded to kernel 2.4.8/2.4.9, i noticed everything became noticably 
slower, and the number of swapins/swapouts increased significantly. When i 
run 'vmstat 1' i see there is a lot of swap activity constantly when i am 
reading my mail in kmail. After a fresh bootup in the evening, i can get 
everything I normally need swapped out by running updatedb or ht://dig. When 
i do that, my music stops playing for several seconds, and it takes about 3 
seconds before my applications repaint when i switch back to X after an 
updatedb run.
the last time that happent (and the last time i had problems with VM at all) 
was in 2.4.0-testXX so i think something is wrong ...
is it possible new used_once does not work for me (and drop_behind used to 
work fine) ?

My system configuration : athlon 750, 384 meg ram, 128 meg swap, XFree4.1 and 
kde2.2.

Greetings,
Frank

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265288AbRF0Hw0>; Wed, 27 Jun 2001 03:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265290AbRF0HwR>; Wed, 27 Jun 2001 03:52:17 -0400
Received: from delrom.ro ([193.231.234.28]:47377 "HELO delrom.ro")
	by vger.kernel.org with SMTP id <S265288AbRF0HwD>;
	Wed, 27 Jun 2001 03:52:03 -0400
Date: Wed, 27 Jun 2001 10:52:56 +0300
From: Silviu Marin-Caea <silviu@delrom.ro>
To: linux-kernel@vger.kernel.org
Subject: Realtek 8139 driver or sucky hardware?
Message-Id: <20010627105256.2e75fdca.silviu@delrom.ro>
Organization: Delta Romania
X-Mailer: Sylpheed version 0.4.99cvs3 (GTK+ 1.2.9; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.7.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server that had a Realtek 8139 card that worked nicely under
normal circumstances.

But I made a mistake in a crontab and I had 60 instances of a backup
script starting one per minute, all of them wishing to create the same
.tar.gz into a samba mounted share.

This crazy situation had the server freeze solid, with only cold boot as
remedy.

No matter what stupid things I do on it, I shouldn't be able to take the
kernel down, right?

After I replaced the Realtek with a 3com, I could see all of the 60
instances fighting like worms in shit, but the server survived.

Kernel 2.4.5 compiled with Red Hat gcc 2.96-81.  With kgcc, it was
acting the same way.

Please CC me.

Thank you.

-- 
Systems and Network Administrator - Delta Romania
Phone +4093-267961

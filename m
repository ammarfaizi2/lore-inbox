Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRE2N6O>; Tue, 29 May 2001 09:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbRE2N6E>; Tue, 29 May 2001 09:58:04 -0400
Received: from [209.10.41.242] ([209.10.41.242]:2764 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262164AbRE2N54>;
	Tue, 29 May 2001 09:57:56 -0400
From: dobos_s@IBCnet.hu
Reply-To: dobos_s@IBCnet.hu
Subject: Re: 2.2.19 locks up on SMP - tcp-hang patch NOT fixed the problem!
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF56FACC45.D8F8889E-ONC1256A5B.004A7C70@ibcnet.hu>
Date: Tue, 29 May 2001 15:50:22 +0200
X-MIMETrack: Serialize by Router on ibchu-teller/IBCnet-HU/IBCGroup(Release 5.0.5 |September
 22, 2000) at 2001.05.29 15:49:41
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the problem.
As I read mails between Alan, Ioan and Trond on the above subject I decided
to try
Trond's tcp-hang patch to see It really solves the problem.

I dont think so. In my source tree there are not compiled files in
net/sunrpc dir, and CONFIG_SUNRPC is not set in my .config!

I use HP E60 machine with four eepro100 cards and with internal AIC7xxx
controller. It is running for a long time uninterrupted
(since there is 2.2.19 kernel)
Today I tried to install freeswan1.9. After establishing ipsec tunnel with
my peer I got the wait_on_bh message.
(I cannot paste exactly because It is a production machine, and I restarted
it as fast as I could)

So what to do?

Please CC to my, I am not subscribed.

Dobos Sandor
IBCnet Hungary Ltd.





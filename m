Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136774AbRECMcU>; Thu, 3 May 2001 08:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136782AbRECMcK>; Thu, 3 May 2001 08:32:10 -0400
Received: from [195.6.125.97] ([195.6.125.97]:26640 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S136774AbRECMb4>;
	Thu, 3 May 2001 08:31:56 -0400
Date: Thu, 3 May 2001 14:29:29 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>,
        liste dev network device <netdev@oss.sgi.com>
Subject: NEWBEE "reverse ioctl" or someting like
Message-Id: <20010503142929.773147bf.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I've made a network driver wich is attached to the serial port.
The network hardware is able to return information to the pc. theses
informations are belong to the configuration of the hardware. I 
succeed on receive information in the driver but I've no idea to alert
higher process (like configuration app ...) that I've received something
(wich is not network data like TCP or ARP etc ...).

I think that use of pipe isn't preconised because I must fork process
to use pipe, I search something like ioctl but in the other way : 

 kernel process ---> user process

Is somebody know the best and easy way ??

thank (I hope this is the right place to ask)

sebastien person

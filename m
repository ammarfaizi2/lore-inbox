Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282452AbRKZTwL>; Mon, 26 Nov 2001 14:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282446AbRKZTuf>; Mon, 26 Nov 2001 14:50:35 -0500
Received: from server1.symplicity.com ([209.61.154.230]:41225 "HELO
	mail2.symplicity.com") by vger.kernel.org with SMTP
	id <S282435AbRKZTt7>; Mon, 26 Nov 2001 14:49:59 -0500
From: "Alok K. Dhir" <alok@dhir.net>
To: <ptb@it.uc3m.es>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Possible md bug in 2.4.16-pre1
Date: Mon, 26 Nov 2001 14:49:28 -0500
Message-ID: <001b01c176b3$75cb5d10$9865fea9@pcsn630778>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <200111261929.UAA31258@nbd.it.uc3m.es>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > down to single user mode does not release the device for 
> stopping.  I 
> > had to reboot to single user mode, then I was able to stop it,
> 
> You just said you couldn't?

Apologies for being unclear - _shutting down_ does *not* allow it to
work (i.e. "shutdown now").  I must first issue a "reboot", and then use
the "-s" flag at the boot prompt to get to single user mode, and then I
am able to stop the raid device...


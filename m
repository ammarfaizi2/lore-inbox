Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281027AbRKGWS6>; Wed, 7 Nov 2001 17:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281026AbRKGWSr>; Wed, 7 Nov 2001 17:18:47 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:39947 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281021AbRKGWSi>;
	Wed, 7 Nov 2001 17:18:38 -0500
Date: Wed, 7 Nov 2001 15:18:06 -0800
From: Greg KH <greg@kroah.com>
To: Stephan Gutschke <stephan@gutschke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011107151806.A22444@kroah.com>
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE9BDD0.2070703@gutschke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE9BDD0.2070703@gutschke.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 10 Oct 2001 21:59:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 12:03:44AM +0100, Stephan Gutschke wrote:
> didn't work :-(
> 
> This is the output of /var/log/syslog if I connect to ttyUSB0
> I am not sure yet though that the problem is in your module.
> I know the jpilot worked, before, but I will still try later
> to connect to the clie with coldsync as well.
> Lets see if that gives anything different.
> Let me know what else I can do to help.

Yes, you will have to use coldsync to talk to this device right now, as
pilot-link doesn't have support for the 4.x Palm OS USB protocol yet
(jpilot uses pilot-link.)

Let me know if coldsync fails (remember you have to tell coldsync that
you are a m50x, and that you want the "simple" protocol, check the docs
for the proper config file setting.)

thanks,

greg k-h

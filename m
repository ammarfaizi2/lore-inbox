Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRJTGsh>; Sat, 20 Oct 2001 02:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275115AbRJTGs1>; Sat, 20 Oct 2001 02:48:27 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:22021 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274862AbRJTGsP>;
	Sat, 20 Oct 2001 02:48:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol hotplug_path in usbcore.o as a module (2.4.12) 
In-Reply-To: Your message of "Fri, 19 Oct 2001 20:21:17 +0100."
             <E15ufCs-0007pL-00@roo.home> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 20 Oct 2001 16:48:37 +1000
Message-ID: <28682.1003560517@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001 20:21:17 +0100, 
Alan Chandler <alan@chandlerfamily.org.uk> wrote:
>I have built the the 2.4.12 kernel with CONFIG_HOTPLUG set and the usb stuff 
>all compiled as modules.
>
>depmod -e  shows that usbcore.o has an unresolved symbol (which of course 
>fails when the module tries to load) of hot_plug path. 

I need the output from
  nm -A `/sbin/modprobe -l`  | grep hotplug_path
  grep hotplug_path /proc/ksyms System.map


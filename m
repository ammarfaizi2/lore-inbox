Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSC1ARZ>; Wed, 27 Mar 2002 19:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSC1ARP>; Wed, 27 Mar 2002 19:17:15 -0500
Received: from codepoet.org ([166.70.14.212]:64173 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287149AbSC1ARI>;
	Wed, 27 Mar 2002 19:17:08 -0500
Date: Wed, 27 Mar 2002 17:17:09 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jos Hulzink <josh@stack.nl>, jw schultz <jw@pegasys.ws>,
        linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
Message-ID: <20020328001709.GA16582@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andre Hedrick <andre@linux-ide.org>, Jos Hulzink <josh@stack.nl>,
	jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
In-Reply-To: <20020327235029.P78593-100000@snail.stack.nl> <Pine.LNX.4.10.10203271553520.6006-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Mar 27, 2002 at 03:57:48PM -0800, Andre Hedrick wrote:
> > If you really want to build in IDE hot swap support, I demand it comes
> > with a warning: Enabling this option will probably destroy your harddisks
> > and your chipset. Feel free to continue, but don't blame us.
> 
> FYI, there was almost a witch hunt when I went into T13 with a SCA4ATA
> proposal.  You understand the issue and I am glad it was you and not me to
> have to bang this drum.  Thanks.

Ok.  How about my laptop?  I have an ATAPI zip drive I can plug
in instead of a second battery.  It is the only device on the
second IDE bus (hdc).  In windows there is a little hotplug
utility thing one runs before unplugging the zip drive.  In Linux
I currently have to reboot if I want the ide-floppy driver to see
the device...  I'm willing to bet that Dell has done mysterious
stuff to make the electrical part work.  It would sure be nice if
I could ask the ide driver to kindly re-scan for /dev/hdc now.

Is whatever windows is doing when I hotplug my zip drive somehow
unsafe, such that supporting the same functionality on Linux is
somehow a Bad Thing(tm)?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

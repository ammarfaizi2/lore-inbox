Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293045AbSBVXrT>; Fri, 22 Feb 2002 18:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293046AbSBVXrK>; Fri, 22 Feb 2002 18:47:10 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:61451 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S293043AbSBVXqy>; Fri, 22 Feb 2002 18:46:54 -0500
Date: Sat, 23 Feb 2002 00:46:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Greg KH <greg@kroah.com>, G?rard Roudier <groudier@free.fr>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020223004652.C9809@suse.cz>
In-Reply-To: <20020222202917.GF9558@kroah.com> <Pine.LNX.4.10.10202221227260.2519-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202221227260.2519-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Fri, Feb 22, 2002 at 12:34:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 12:34:12PM -0800, Andre Hedrick wrote:

> > Nothing.  It is the same problem for IDE PCI drivers.  In order for PCI
> > Hotplug to work on these devices, they have to implement the 2.4 pci
> > interface.  If they do that, they work with PCI hotplug systems.  If
> > they do not, they don't.
> 
> Okay, but where is a card that is capable, and cardbus is not the same
> issue.

Any PCI card can be hot-plugged and hot-unplugged if the *mainboard*
supports it. Still talking about (un)plugging the controllers, not the
drives. And this is the same issue as cardbus.

-- 
Vojtech Pavlik
SuSE Labs

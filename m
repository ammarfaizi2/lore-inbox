Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTBBORH>; Sun, 2 Feb 2003 09:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTBBORH>; Sun, 2 Feb 2003 09:17:07 -0500
Received: from ulima.unil.ch ([130.223.144.143]:9872 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S265275AbTBBORG>;
	Sun, 2 Feb 2003 09:17:06 -0500
Date: Sun, 2 Feb 2003 15:26:36 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is usb working under 2.5.59?
Message-ID: <20030202142636.GA354@ulima.unil.ch>
References: <20030202111657.GA31683@ulima.unil.ch> <20030202140643.GS31566@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030202140643.GS31566@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 03:06:43PM +0100, Jens Axboe wrote:
> > Hello,
> > 
> > I used to use usb under 2.4 with my Digital Ixus V with s10sh.
> > It worked just perfectly, now under 2.5.59, I don't even see the output
> > of a recongnize in the syslogd.
> > 
> > I have also tried gphoto2, which doesn't find any camera...
> 
> Check that you have ohci/uhci in addition to the ehci controller, I just
> spent an hour finding out why 1.x devices didn't work on my via board
> (thanks David :)...

Well, yes I have it...as I put in
http://ulima.unil.ch/greg/linux/MAX2/lsmod-2.5.59 

ehci_hcd               17792  0 
ohci_hcd               12672  0 

Thank you very much, all suggestion are greatly appreciated ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288113AbSACBdy>; Wed, 2 Jan 2002 20:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288107AbSACBdp>; Wed, 2 Jan 2002 20:33:45 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:32270 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288108AbSACBdj>;
	Wed, 2 Jan 2002 20:33:39 -0500
Date: Wed, 2 Jan 2002 17:32:31 -0800
From: Greg KH <greg@kroah.com>
To: Roger Leblanc <r_leblanc@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
Message-ID: <20020103013231.GA4952@kroah.com>
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca> <20020103002827.GA4462@kroah.com> <3C33AF4F.7000703@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C33AF4F.7000703@videotron.ca>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 05 Dec 2001 23:24:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 08:09:35PM -0500, Roger Leblanc wrote:
> Mmmm, I should have guessed that one. Scanner is quite a good name for a 
> scanner module ;-). Anyway, I moved things around so "scanner" and all 
> the other device specific modules are unloaded before usb-uhci but yet, 
> it doesn't help. It still freeses when unload usb-uhci. Any idea?

Hm, if you umount usbdevfs before unloading usb-uhci, does that work?

greg k-h

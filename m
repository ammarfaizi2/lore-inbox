Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292555AbSBUWNE>; Thu, 21 Feb 2002 17:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292552AbSBUWM4>; Thu, 21 Feb 2002 17:12:56 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:25614 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292555AbSBUWMl>;
	Thu, 21 Feb 2002 17:12:41 -0500
Date: Thu, 21 Feb 2002 14:07:14 -0800
From: Greg KH <greg@kroah.com>
To: "J.P. Morris" <jpm@it-he.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-rc2 problem..
Message-ID: <20020221220714.GI4984@kroah.com>
In-Reply-To: <20020220185855.2bcecc24.jpm@it-he.org> <20020220190509.GA30784@kroah.com> <20020221200459.642e3bb3.jpm@it-he.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020221200459.642e3bb3.jpm@it-he.org>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 24 Jan 2002 18:54:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 08:04:59PM +0000, J.P. Morris wrote:
> 
> Note that the kernel itself doesn't lock, just the module.
> That is, the module never completes initialisation and sits there forever.
> When it was being loaded by script at boot, I had to use Alt-Sys-K to kill
> the process trying to load the module in order to log in.
> 
> I have tried upgrading just the usb-storage module from 2.4.17 to 2.4.18
> and (unfortunately) it still works.. the cause of the problem is elsewhere.
> 
> Any ideas?  Thanks.

Enable debugging in the usb-storage driver, and send the kernel debug
output to the usb-storage author and maintainer :)

Good luck,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288093AbSACAWO>; Wed, 2 Jan 2002 19:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288061AbSACAUd>; Wed, 2 Jan 2002 19:20:33 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:16654 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288052AbSACATU>;
	Wed, 2 Jan 2002 19:19:20 -0500
Date: Wed, 2 Jan 2002 16:18:16 -0800
From: Greg KH <greg@kroah.com>
To: Roger Leblanc <r_leblanc@videotron.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
Message-ID: <20020103001816.GB4162@kroah.com>
In-Reply-To: <3C33A22F.40906@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C33A22F.40906@videotron.ca>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 05 Dec 2001 21:46:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 07:13:35PM -0500, Roger Leblanc wrote:
> It doesn't get that far. The first thing my init script (or Mandrake 8.1 
> script) does at shutdown is to run modprobe -r on modules usb-ohci, 
> usb-uhci and uhci. The system freeses when it gets to usb-uhci. It does 
> it also if I run these commands on the command line.

Have you unloaded your scanner module before unloading the usb-uhci
module?

thanks,

greg k-h

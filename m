Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSBRAOF>; Sun, 17 Feb 2002 19:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293396AbSBRAN4>; Sun, 17 Feb 2002 19:13:56 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:39684 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293386AbSBRANf>;
	Sun, 17 Feb 2002 19:13:35 -0500
Date: Sun, 17 Feb 2002 16:08:47 -0800
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: khubd blocking in D state with 2.5.5-pre1
Message-ID: <20020218000847.GA17106@kroah.com>
In-Reply-To: <3C702FE3.B914C0D@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C702FE3.B914C0D@delusion.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 20 Jan 2002 22:05:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2002 at 11:34:11PM +0100, Udo A. Steinberg wrote:
> 
> My monitor acts as USB hub. When the monitor is switched off and then back
> on the khubd kernel thread blocks in D state:

<snip>

> Is this a known problem?

Yes it is.  See the lkml archives for some patches from me and Pat
Mochel that fix this problem.  It is a combination of bugs in both the
USB core, and the driverfs code that cause this.

thanks,

greg k-h

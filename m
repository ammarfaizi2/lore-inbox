Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268941AbTBSP4m>; Wed, 19 Feb 2003 10:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268942AbTBSP4m>; Wed, 19 Feb 2003 10:56:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33553 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268941AbTBSP4l>;
	Wed, 19 Feb 2003 10:56:41 -0500
Date: Wed, 19 Feb 2003 07:59:48 -0800
From: Greg KH <greg@kroah.com>
To: Martin Furter <mf@rola.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb ftdi_sio kernel 2.4.20 panic
Message-ID: <20030219155948.GA16231@kroah.com>
References: <Pine.LNX.4.21.0302112220540.24477-100000@gate.rola.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0302112220540.24477-100000@gate.rola.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 10:31:13PM +0100, Martin Furter wrote:
> 
> Hello all!
> 
> I connected the USB-Serial Converter via a nullmodem cable to ttyS0 and
> the isuued the following commands:
> tty1> cat /dev/ttyS0
> tty2> echo hello > /dev/ttyUSB0
> The I get a kernel panic, the output of ksymoops is included.

Yeah, lots of people are getting this lately, unfortunatly I can't
duplicate it :(

But I think it's now fixed up in the latest 2.5-bk tree.  If you could
test 2.5.62 and 2.5.63 when it comes out and let me know if it still
happens there, I would greatly appreciate it.

thanks,

greg k-h

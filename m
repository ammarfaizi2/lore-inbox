Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287623AbRLaTu3>; Mon, 31 Dec 2001 14:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287627AbRLaTuT>; Mon, 31 Dec 2001 14:50:19 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:46600 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287623AbRLaTuL>;
	Mon, 31 Dec 2001 14:50:11 -0500
Date: Mon, 31 Dec 2001 11:49:33 -0800
From: Greg KH <greg@kroah.com>
To: hingwah@computer.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops for 2.4.12
Message-ID: <20011231114933.G20250@kroah.com>
In-Reply-To: <20011231183554.GA2342@hingwah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231183554.GA2342@hingwah>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 03 Dec 2001 17:41:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2002 at 02:35:54AM +0800, hingwah@computer.org wrote:
> My computer hang when I plug out the USB palm hotsync cable which is
> identified as Proliferic usb serial converter which use pl2303.o as module
> and plug in the usb mouse
> after reboot,the following oops message is found in /var/log/messages

The pl2303 driver has had a number of fixes since the 2.4.12 kernel.
Can you try the latest version (in 2.4.17)?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318358AbSG3RWu>; Tue, 30 Jul 2002 13:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318359AbSG3RWu>; Tue, 30 Jul 2002 13:22:50 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:36613 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318358AbSG3RWt>;
	Tue, 30 Jul 2002 13:22:49 -0400
Date: Tue, 30 Jul 2002 10:24:54 -0700
From: Greg KH <greg@kroah.com>
To: kees <kees@schoen.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19.rc3 vs 2.4.17
Message-ID: <20020730172454.GG15359@kroah.com>
References: <Pine.LNX.4.33.0207272012340.1731-100000@schoen3.schoen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207272012340.1731-100000@schoen3.schoen.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 02 Jul 2002 14:38:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 08:15:10PM +0200, kees wrote:
>  My pencam program didn't download pictures under
> 2.4.19rc3 and it does under 2.4.17.

This is probably because you now have a USB kernel driver binding to
your pencam device (stv680).  Either unload it and then run your
userspace program, or don't build that driver at all.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUHQEnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUHQEnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbUHQEny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:43:54 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:7346 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268097AbUHQEnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:43:52 -0400
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Rahul Jain <rbj2@oak.njit.edu>
Date: Tue, 17 Aug 2004 14:43:43 +1000
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Kernel recompilation error
Message-ID: <20040817044343.GA17796@cse.unsw.EDU.AU>
Mail-Followup-To: Rahul Jain <rbj2@oak.njit.edu>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.58.0408162058310.17241@chrome.njit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0408162058310.17241@chrome.njit.edu>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul
As a guess the kernel you are compiling on
does not have loopback enabled and therefore
you are seeing this message.

I use to see this message on RH7 and 8 if
I had no loopback device.

Darren

On Mon, 16 Aug 2004, Rahul Jain wrote:

> Hi,
> 
> This is the first time I am seeing this error while recompiling the
> kernel. Could someone plz explain what it means and how to fix it.
> 
> I get this error message when I run the command 'make install'. Till this
> point everything else works out properly.
> 
> Error Message
> -------------
> All of your loopback devices are in use.
> mkinitrd failed
> 
> The commands run before this were
> make mrproper
> make menuconfig
> make dep
> make bzImage
> make modules and
> make modules_install
> 
> Thanks,
> Rahul.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

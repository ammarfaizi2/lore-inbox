Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbULZBbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbULZBbF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 20:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULZBbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 20:31:04 -0500
Received: from main.gmane.org ([80.91.229.2]:18588 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261600AbULZBaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 20:30:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: bug: cd-rom autoclose no longer works in 2.6.9/2.6.10
Date: Sun, 26 Dec 2004 03:30:03 +0200
Message-ID: <pan.2004.12.26.01.30.02.77370@yahoo.com>
References: <41CE0723.8030008@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home-33027.b.astral.ro
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stas,

Does 
cat /proc/sys/dev/cdrom/autoclose
return 1 or 0 ?

On Sun, 26 Dec 2004 03:34:43 +0300, Stas Sergeev wrote:

> Hello.
> 
> CD-ROM autoclose stopped working for
> me quite some time ago. I used to type only "mount /mnt/cdrom" and that
> took care about closing, but now I am getting this:
> ---
> $ mount /mnt/cdrom
> mount: No medium found
> ---
> so I have to do "eject -t" first.
> I can reproduce this problem on 2
> completely different machines, so I
> don't think this have something to
> do with the particular hardware.
> The configuration haven't changed
> either:
> 
> $ cat /proc/sys/dev/cdrom/autoclose
> 1
> 
> $ cat /proc/sys/dev/cdrom/info
> CD-ROM information, Id: cdrom.c 3.20 2003/12/17
>  
> drive name:             hdd
> drive speed:            50
> drive # of slots:       1
> Can close tray:         1
> Can open tray:          1
> Can lock tray:          1
> Can change speed:       1
> Can select disk:        0
> Can read multisession:  1
> Can read MCN:           1
> Reports media changed:  1
> Can play audio:         1
> Can write CD-R:         0
> Can write CD-RW:        0
> Can read DVD:           0
> Can write DVD-R:        0
> Can write DVD-RAM:      0
> Can read MRW:           1
> Can write MRW:          1
> Can write RAM:          1



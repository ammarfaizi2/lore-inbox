Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277975AbRJOCZe>; Sun, 14 Oct 2001 22:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277983AbRJOCZY>; Sun, 14 Oct 2001 22:25:24 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:32245
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277975AbRJOCZQ>; Sun, 14 Oct 2001 22:25:16 -0400
Date: Sun, 14 Oct 2001 19:25:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Cyrus <cyrus@linuxmail.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Large Storage Devices in Linux.....Kernel level support.....
Message-ID: <20011014192542.C28547@mikef-linux.matchmail.com>
Mail-Followup-To: Cyrus <cyrus@linuxmail.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BC93DCB.20400@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC93DCB.20400@linuxmail.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 05:24:59PM +1000, Cyrus wrote:
> hi all,
> 
> i've got a setup of 2 hard drives (30GB & 40GB) with an Asus a7m266 mobo 
> with a VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06).
> 
> 30GB= fujitsu, 40GB= IBM (both are 7200rpm
> 
> i've got my cdrw on /dev/hdc, 30GB=/dev/hda, and 40GB=/dev/hdb...
> 
> all works alright for a while, but when i keep my computer turned on for 
> a couple of days and then reboot. bios sometimes tells me that smart 
> array (or something) failed with my primary master (30GB) and i should 
> back-up soon.. next reboot it tells me that pri-master fails.. it's 
> doing this quite regularly and i don't know how to stop it. i'm running 

Turn off "S.M.A.R.T." in your bios...  Probably under the advanced bios
config menu.

I know that Compaq has a SMART RAID controller, but does anyone know what
this does?  (I've seen it on old p2 MBs and they didn't have raid...)

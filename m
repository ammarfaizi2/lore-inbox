Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSJPVRq>; Wed, 16 Oct 2002 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJPVRq>; Wed, 16 Oct 2002 17:17:46 -0400
Received: from komoseva.globalnet.hr ([213.149.32.250]:8458 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id <S261393AbSJPVRp>; Wed, 16 Oct 2002 17:17:45 -0400
Date: Wed, 16 Oct 2002 23:10:29 +0200
From: Vid Strpic <vms@bofhlet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: usb CF reader and 2.4.19
Message-ID: <20021016231028.H2466@localhost>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <no.id>; from jowenn@kde.org on Wed, Oct 16, 2002 at 11:22:04AM +0200
X-Operating-System: Linux 2.4.19rml
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled May  3 2002 20:49:56)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 11:22:04AM +0200, Joseph Wenninger wrote:
> Is there anything I can do to flush all usb / usb storage buffers to
> my compact flash ? 
> At the moment I have to rmmod usb-storage && rmmod usb-uhci &&
> modprobe usb-uhci && modprobe usb-storage to ensure all data is
> written correctly, otherwise the directory structure isn't saved even
> after an unmount.

eject sda|whichever device it is, maybe?

Works here with my SM/CF reader.

-- 
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux lorien 2.4.19rml #1 Mon Sep 16 09:01:48 CEST 2002 i586
 23:08:58 up 3 days,  5:29, 26 users,  load average: 2.17, 1.49, 0.97

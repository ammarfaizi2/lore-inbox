Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWCMUNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWCMUNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWCMUM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:12:59 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:23731
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S964778AbWCMUM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:12:58 -0500
Date: Mon, 13 Mar 2006 12:09:15 +0000
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com,
       linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com,
       dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com,
       Olaf Hering <olh@suse.de>, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org, Tom Seeley <redhat@tomseeley.co.uk>,
       Jiri Slaby <jirislaby@gmail.com>, laredo@gnu.org,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
Subject: Re: 2.6.16-rc6: known regressions
Message-ID: <20060313120915.GA13652@suse.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313200544.GG13973@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 09:05:44PM +0100, Adrian Bunk wrote:
> Subject    : Slab corruption in usbserial when disconnecting device
> References : http://lkml.org/lkml/2006/3/8/58
> Submitter  : pete.chapman@exgate.tek.com
> Status     : unknown

Should already be fixed in 2.6.16-rc6, with this patch that went in
after 2.6.16-rc5 came out:
	http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=91c0bce29e4050a59ee5fdc1192b60bbf8693a6d

Pete, can you verify this change works for you?

thanks,

greg k-h

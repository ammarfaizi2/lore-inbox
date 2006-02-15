Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946045AbWBOR3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946045AbWBOR3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946050AbWBOR3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:29:36 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9191 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946045AbWBOR3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:29:35 -0500
Subject: Re: RFC: disk geometry via sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43F354E9.2020900@cfl.rr.com>
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>
	 <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>
	 <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>
	 <43F2E8BA.90001@bfh.ch>
	 <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com>
	 <1140019615.14831.22.camel@localhost.localdomain>
	 <43F354E9.2020900@cfl.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Feb 2006 17:32:34 +0000
Message-Id: <1140024754.14831.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-15 at 11:20 -0500, Phillip Susi wrote:
> Why do you say the partitioning tool needs to know the disk reported 
> C/H/S?  The value stored in the MBR must match the bios reported values, 
> not the disk reported ones, so why does the partitioner care about what 
> the disk reports?

You answered that in asking the question.  "The value stored in the MBR
must match the ...". What if the MBR has not yet been written ?

(Also btw its *should*...) most modern OS's will take a sane MBR
geometry and trust it over BIOS defaults.

Alan


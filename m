Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUBVOeK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 09:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUBVOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 09:34:10 -0500
Received: from p10068181.pureserver.de ([217.160.75.209]:49424 "EHLO
	www.kuix.de") by vger.kernel.org with ESMTP id S261344AbUBVOeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 09:34:07 -0500
Message-ID: <4038BDC3.9030304@kuix.de>
Date: Sun, 22 Feb 2004 15:33:39 +0100
From: Kai Engert <kaie@kuix.de>
Reply-To: kai.engert@gmx.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030721 wamcom.org
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: only ieee1394 from 2.4.20 works for me
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last year I have been playing with a variety of combinations of 
ieee1394 controllers, machines, external mass storage devices and linux 
kernel versions. So have some friends of mine.

The only version that works for us is the ieee1394 code that was 
included with kernel version 2.4.20.

(I removed drivers/ieee1394 completely, and replaced it with 
drivers/ieee1394 from 2.4.20)

Using that snapshot, we are able to transfer data to disks and video 
from a camcorder just fine, in all combinations we have tested.

Every other kernel version, both older or newer than 2.4.20, is broken. 
We either see random errors, or writing data to disks stalls 
immediately, or daisy chained devices don't work.

I'm currently using the official Fedora core 1 series kernels, patched 
that way, and it works like a charm.

Please consider to use the 2.4.20 ieee1394 snapshot in future 2.4.x 
releases.

Best Regards,
Kai


PS: Please CC me on replies.


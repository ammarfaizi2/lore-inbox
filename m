Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbUCOJvA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbUCOJvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:51:00 -0500
Received: from cpc3-hitc2-5-0-cust51.lutn.cable.ntl.com ([81.99.82.51]:37855
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S262483AbUCOJu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:50:59 -0500
Message-ID: <40555F23.4020600@reactivated.net>
Date: Mon, 15 Mar 2004 07:45:39 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hotplug with Kernel 2.6
References: <20040315102735.16ae4397.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20040315102735.16ae4397.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christoph Pleger wrote:
> When I hotplug (or unplug) a USB mass storage device, I want to find out
> which SCSI device (for example, /dev/sda or /dev/sdb) is (was) assigned
> to that USB Device. Is it possible to do that with the help of the
> variables which are passed to the hotplug scripts by the kernel?

Not a direct answer to your question, but you might want to try udev. You can 
set up rules so that your USB storage device always becomes /dev/usb_hard_disk 
or another name of your choosing (as well as the automatic /dev/sdX).

Daniel

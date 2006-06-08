Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWFHRBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWFHRBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 13:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWFHRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 13:01:50 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:524 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964909AbWFHRBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 13:01:49 -0400
Message-ID: <44885835.9060403@gentoo.org>
Date: Thu, 08 Jun 2006 18:02:45 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: andreas@rittershofer.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6, bcm43xx and WPA
References: <1149762392.3781.7.camel@coredump>
In-Reply-To: <1149762392.3781.7.camel@coredump>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Rittershofer wrote:
> Authentication to my AP is not possible, the problem seems to be:
> 
> ioctl[SIOCSIWENCODEEXT]: Invalid argument
> Driver did not support SIOCSIWENCODEEXT
> WPA: Failed to set PTK to the driver.

Looks like you didn't compile the relevant software encryption support 
into your kernel.

> So it seems that the bcm43xx-driver included in this kernel versions is
> not ok - I cannot connect to my AP using WPA.

WPA through softmac is flaky (at least it is with ZD1211), it works for 
some but not for others.

Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269820AbUJHLUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269820AbUJHLUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269837AbUJHLUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:20:21 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:37527 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S269820AbUJHLSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:18:22 -0400
Subject: Re: hang after resume with adb: starting probe task.
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097189899.16161.6.camel@gaston>
References: <1097172895.3281.31.camel@localhost>
	 <1097189899.16161.6.camel@gaston>
Content-Type: text/plain
Date: Fri, 08 Oct 2004 13:17:48 +0200
Message-Id: <1097234268.3339.27.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 08:58 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2004-10-08 at 04:14, Soeren Sonnenburg wrote:
> > As of at least kernel version 2.6.9-rc2 I pretty often see the kernel
> > hang after returning from sleep mode hanging with the message "adb:
> > starting with probe task". This still happens with 2.6.9-rc3 but never
> > happened with 2.6.8.1.
> 
> I doubt it has anything to do with ADB. The ADB probe is asynchronous,
> it's more something that is coming back at the same time that is
> crashing, maybe ethernet link, or USB... Can you try without anything
> plugged in ethernet if you had anything of course ? and with nothing
> in USB as well ?

Actually there was nothing plugged into the ethernet nor usb port. Could
it also be the airport failing ? I still use orinoco cvs, i.e. airport
0.15rc2HEAD, but that one also on 2.6.8.1. 

I now have a more or less reliable way of making this pbook crash: put
it to sleep and wake it up as soon it is sleeping.

HTH
Soeren
-- 
"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety." Benjamin Franklin


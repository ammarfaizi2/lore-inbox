Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269921AbUJGXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269921AbUJGXKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269891AbUJGXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:07:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:43939 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268232AbUJGXHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:07:21 -0400
Subject: Re: hang after resume with adb: starting probe task.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1097172895.3281.31.camel@localhost>
References: <1097172895.3281.31.camel@localhost>
Content-Type: text/plain
Message-Id: <1097189899.16161.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 08:58:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 04:14, Soeren Sonnenburg wrote:
> As of at least kernel version 2.6.9-rc2 I pretty often see the kernel
> hang after returning from sleep mode hanging with the message "adb:
> starting with probe task". This still happens with 2.6.9-rc3 but never
> happened with 2.6.8.1.

I doubt it has anything to do with ADB. The ADB probe is asynchronous,
it's more something that is coming back at the same time that is
crashing, maybe ethernet link, or USB... Can you try without anything
plugged in ethernet if you had anything of course ? and with nothing
in USB as well ?

Ben.



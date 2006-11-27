Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757457AbWK0Iud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbWK0Iud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757465AbWK0Iud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:50:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43473 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757457AbWK0Iuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:50:32 -0500
Subject: Re: Weird wasting of time between ioctl() and ioctl dispatcher
From: Arjan van de Ven <arjan@infradead.org>
To: "Cestonaro, Thilo (external)" 
	<Thilo.Cestonaro.external@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5863@ABGEX01E.abg.fsc.net>
References: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5863@ABGEX01E.abg.fsc.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 27 Nov 2006 09:50:29 +0100
Message-Id: <1164617429.3276.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-27 at 09:24 +0100, Cestonaro, Thilo (external) wrote:
> Hey,
> 
> I'm a developer for Fujitsu Siemens Computers, working on a program which has it's own kernel modules and userland components.
> Now cause the program should be released we have done some testing and during this testphase a wierd wasting of time occured
> during the call of the ioctl() in the userland component and the actuall entering of the dispatcher function in the module.
> It takes 3 min. until the call at last enters my dispatcher. (Debugging output with printf on line before ioctl() and printk as first line in the 
> dispatch function points that out). The dispatch function is the ioctl part of the fileoperations struct which defines the module stuff.
> 
> The kernel I'm running is the 2.6.16.21-0.8-default of SLED10 (32Bit), but installed on a 64Bit machine.
> Can anyone point me to, where I can have a look where the waste of time comes from?
> 
> The ioctl itself works fine afterwards, but the whole process is time-critical so the 3 min. do hurt :(.


Hi,

unfortunately you did not post the source code of at least your kernel
driver, nor did you provide an URL to the source, so it's really hard
for us to help you. Would you mind correcting this oversight?

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org


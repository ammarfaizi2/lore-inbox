Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268908AbTGOQaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbTGOQ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:28:33 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:58532 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S268727AbTGOQ0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:26:23 -0400
Date: Tue, 15 Jul 2003 18:42:51 +0200
From: Mattia Dongili <dongili@supereva.it>
To: ian.soboroff@nist.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 - cpu_freg sysfs nodes?
Message-ID: <20030715164251.GA2623@inferi.kami.home>
Reply-To: dongili@supereva.it
Mail-Followup-To: ian.soboroff@nist.gov, linux-kernel@vger.kernel.org
References: <m34r1n3e93.fsf@euphrates.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34r1n3e93.fsf@euphrates.ncsl.nist.gov>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 01:12:56PM -0400, ian.soboroff@nist.gov wrote:
> 
> I'm running 2.6.0-test1 on my Fujitsu P-2110 laptop, but the cpufreq
> stuff doesn't seem to be working.  Well, this is the symptom, but the
> problem might actually be higher up:
> 
> # ls /sys/class/
> input  net  pcmcia_socket  scsi_device  scsi_host  tty  usb  usb_host
> 
> Note, no 'cpu' class.  /proc/cpufreq no longer works (as
> expected)... using the longrun utility to frob the MSR manually works
> fine.

find /sys -iname 'cpu*'

/sys/firmware/acpi/namespace/ACPI/CPU0
/sys/devices/system/cpu
/sys/devices/system/cpu/cpu0
/sys/devices/system/cpu/cpu0/cpufreq
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq

:)
-- 
mattia
:wq!

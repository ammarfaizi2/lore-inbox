Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSJ1KEE>; Mon, 28 Oct 2002 05:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbSJ1KEE>; Mon, 28 Oct 2002 05:04:04 -0500
Received: from dhcp16654186.neo.rr.com ([24.166.54.186]:390 "EHLO
	viper.vortech.net") by vger.kernel.org with ESMTP
	id <S263228AbSJ1KED> convert rfc822-to-8bit; Mon, 28 Oct 2002 05:04:03 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Joshua Jackson <linux-kernel@vortech.net>
Reply-To: linux-kernel@vortech.net
Organization: Vortech Consulting
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 kmod problem with linuxrc
Date: Mon, 28 Oct 2002 06:10:25 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210280510.25141.linux-kernel@vortech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been developing a small, embedded disrtibution of Linux for the past 
couple years and just ran into a snag when upgrading to the 2.4.19 kernel.  
After upgrading from 2.4.18 to 2.4.19 with an identical config, kmod fails to 
load ANY modules with the typical:

kmod: failed to exec /sbin/modprobe -s -k <modulename>

The system is designed such that during boot an initial ramdrive is loaded and 
never exited... much like installer floppies, etc. If the failed modprobe 
command is executed from the command line, it works fine.

The system uses a BusyBox init, full bash shell and the modprobe version is 
2.4.18.

--
Joshua Jackson
jjackson@vortech.net
http://www.coyotelinux.com

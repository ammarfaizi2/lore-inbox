Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVG2QqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVG2QqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVG2QqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:46:05 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:49616 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262660AbVG2QoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:44:15 -0400
Date: Fri, 29 Jul 2005 18:44:14 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces (2)
Message-ID: <20050729164414.GA19120@janus>
References: <20050729162006.GA18866@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729162006.GA18866@janus>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In addition, /proc/bus/usb got mounted but /proc/bus seems have changed into a file:

$ df
df: `/proc/bus/usb': Not a directory
   ...
$ grep usb /proc/mounts
usbfs /proc/bus/usb usbfs rw 0 0
$ ls -l /proc/bus
-r--r--r--  1 root root 0 Jul 29 17:54 /proc/bus
$ cat /proc/bus
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
  eth0: 2440261   10169    0    0    0     0          0        97  1287588    4726    0    0    0     0       0          0
    lo:   34526     173    0    0    0     0          0         0    34526     173    0    0    0     0       0          0
dummy0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
 tunl0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
  gre0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0

-- 
Frank

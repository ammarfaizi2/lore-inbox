Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTEIX4f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTEIX4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:56:35 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:55560 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S263597AbTEIX4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:56:34 -0400
Message-ID: <3EBC43CC.3090808@interlog.com>
Date: Sat, 10 May 2003 10:11:56 +1000
From: Douglas Gilbert <dgilbert@interlog.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Robert.L.Harris@rdlg.net
Subject: Re: removing a single device?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:
 > A long time ago I used to be able to do:
 >
 > echo "scsi add-single-device 0 0 11 0" > /proc/scsi/scsi
 > echo "scsi remove-single-device 0 0 11 0" > /proc/scsi/scsi
 >
 > When I wanted to unplug a SCA scsi drive for replacement.  I tried this
 > recently on my 2.4.20 kernel and nothing happened.  No errors, no change
 > to /proc/scsi/scsi, no entry in dmsg, it just ignored it.  Has this been
 > deprecated for a new way of removing hotswap drives?

Robert,
It is not deprecated (and is still present in the lk 2.5
development series since we still have no other way of
doing this from the user space).

The parsing of that expression is very rigid: no tabs
or redundant spaces.

Doug Gilbert


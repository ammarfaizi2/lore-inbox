Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVLDQWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVLDQWE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVLDQWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:22:04 -0500
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:31939 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S932268AbVLDQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:22:03 -0500
Message-ID: <43931829.60806@austin.rr.com>
Date: Sun, 04 Dec 2005 10:24:09 -0600
From: "Jonathan A. George" <jageorge@austin.rr.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unneeded RFC: Starting a stable kernel series off the 2.6 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is really a silly discussion:

2.6.x release is the initial base for each stable release
    !with absolutely no intention of stalling non-useland API's!

2.6.x.y releases are the stability updates to the base release
    and in kernel API's will usually stay stable

If you want an ultra stable kernel you should start with the last stable 
release and start tracking what you consider critical fixes from the 
next base kernel (2.6.x) forward (essentially creating your own vendor 
branch).  Alternatively you should use a vendor branch which already 
does this for you with the addition of back porting important new device 
drivers (Debian Stable, RHEL, SLES, ...).

The 2.6 development model finally gives developers the ability to dump 
cruft, fix broken architecture, and add performance enhancements in a 
timely manor.  Linux development hasn't worked this well since 1.2 was 
small enough to test and release quickly.


OTOH it would be nice if core userland (libc, udev, binutils, 
shellutils) were managed as a single project (as with OpenBSD) so that 
userland breakage would be better managed. :-)

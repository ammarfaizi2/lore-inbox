Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbUL1Oh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUL1Oh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 09:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUL1Oh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 09:37:57 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:8072 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261241AbUL1Ohq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 09:37:46 -0500
Date: Tue, 28 Dec 2004 09:33:54 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Martin Dalecki <martin@dalecki.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK] disconnected operation
In-Reply-To: <92984B55-577B-11D9-BCB8-000A95E3BCE4@dalecki.de>
Message-ID: <Pine.GSO.4.33.0412280925010.6921-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, Martin Dalecki wrote:
>A hostname simply isn't a fixed attribute of a host anymore.

It is on properly setup and maintained machines.

The problem are all those people writing programs that think they are doing
the world a favor by screwing with the hostname and various other settings
for us... there's no reason for dhcp to change my hostname.  At least on
linux, no dhcp implementation touches /etc/hosts. (Solaris has screwed up
the hosts file for years.)

These are the same machines that don't have FQDN's as the first name per
entry in /etc/hosts (which pisses off many incarnations of glibc.) *grin*

--Ricky

PS: When you're off-line, /etc/resolv.conf shouldn't have any nameservers
    listed.  They aren't going to be connectable.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTL2B4k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 20:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTL2B4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 20:56:39 -0500
Received: from 12-211-64-253.client.attbi.com ([12.211.64.253]:43159 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S262331AbTL2B4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 20:56:38 -0500
Message-ID: <3FEF89D5.4090103@comcast.net>
Date: Sun, 28 Dec 2003 17:56:37 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ed.sweetman@wmich.edu
Subject: Re: Can't eject a previously mounted CD?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does everyone who has this problem by chance have it occuring on an 
> atapi cd recorder.  As of 2.6.0-mm1 my cd recorder is being labeled read 
> only by the ide-cd driver.  Meaning, no matter if i set the readonly 
> flag in hdparm to 0, cdrecord and others will refuse to write to the 
> drive because it's being told it's read only.  I do not have fam loaded 
> at the time of this testing.  Are there new ide-cd arguments required to 
> use atapi cd writers in native mode?
> 
> 

I have it happening on both my optical drives. One is a lite-on ATAPI cd-rw, the
other an ATAPI Pioneer dvd-rw/cd-rw.  No fam/gnome running. I do use automount
with these drives, but I can see that the mounts have been expired, yet I can't
eject them using the button. Tested last night using both ide-cd and ide-scsi.
Same result with either access. When they're locked, fuser shows nothing
attached, as does lsof. I can eject them with the eject command.

-Walt






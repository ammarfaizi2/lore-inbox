Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUACG0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 01:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265926AbUACG0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 01:26:11 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:24301 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262767AbUACG0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 01:26:11 -0500
Date: Fri, 02 Jan 2004 22:24:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Long pauses (IO?) whilst ripping DVDs
Message-ID: <2950000.1073111086@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Start transcode in one window, doing something like:
"transcode -i /dev/hdc -x dvd -U file_name -y divx4"
on a DVD ... probably pretty CPU intensive as well as IO.

Now do ls in another window ... hangs for about 5 seconds before
giving any output ;-( Anyone else seeing that? I do get a lot of
"*** libdvdread: CHECK_VALUE failed in nav_read.c:202 ***"
messages as well ... but I always seem to get those from DVD stuff.

All IDE, 2.6.0-rc1.

M.




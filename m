Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUEGIrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUEGIrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 04:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUEGIoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 04:44:17 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:27878 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263309AbUEGInr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 04:43:47 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Oliver Pitzeier" <oliver@linux-kernel.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Linux behaviour!? 
In-reply-to: Your message of "Fri, 07 May 2004 10:33:02 +0200."
             <013001c4340d$e9860470$d50110ac@sbp.uptime.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 May 2004 18:43:25 +1000
Message-ID: <13183.1083919405@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004 10:33:02 +0200, 
"Oliver Pitzeier" <oliver@linux-kernel.at> wrote:
>We have a machine with five partitions mounted. One of those partitions
>is /usr. We can created files on /usr, but we cannot created
>directories. mkdir says, that there is no space left on device, but
>there actually IS space as you can see and files can be created, so why
>NO directories?

df -i, you have run out of inodes.


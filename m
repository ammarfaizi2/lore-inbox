Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266210AbUFPHn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUFPHn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUFPHn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:43:28 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:23519 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S266210AbUFPHn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:43:26 -0400
Date: Wed, 16 Jun 2004 09:43:22 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Micah Anderson <micah@riseup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.6 grinds to a halt with moderate I/O
Message-Id: <20040616094322.559b951d@philou.gramoulle.local>
In-Reply-To: <20040615154745.GD22650@riseup.net>
References: <20040615154745.GD22650@riseup.net>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Micah,

Could you give more information on the Megaraid part of your setup ?

Are the i/o made on a disk/partition controlled by the megaraid ?

If no, does the same behavior occur on a plain scsi disk ?

If yes, what kind of RAID level do you use ? how many disks ? 

Could you give megaraid firmware information as well as logical volume settings regarding
read,write and cache policy.

Also, is it a regression over previous kernels, like 2.6.5 or even earlier kernels ?

I've been using 2.6.3-mm3 for weeks now with DELL hardware and a megaraid controller
doing intensive i/o around the clock without any problems. The box has been just rock solid.

Thanks,

Philippe

On Tue, 15 Jun 2004 10:47:45 -0500
Micah Anderson <micah@riseup.net> wrote:

  | 
  | Following the format from REPORTING-BUGS please see the below information.
  | I unfortunately cannot subscribe to the list, but will follow the thread. I
  | have searched high and low, read a number of threads somewhat tangential to
  | this problem, and asked a few times in #kernelnewbies before I got to my
  | wits end and now will try here. I really appreciate any insight anyone has,
  | and will be happy to provide more information or additional tests
  | [snip]

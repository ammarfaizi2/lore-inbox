Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbTDKAF4 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTDKAF4 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:05:56 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:30739 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264117AbTDKAFz (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 20:05:55 -0400
Date: Fri, 11 Apr 2003 02:17:27 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Lang <david.lang@digitalinsight.com>
cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <Pine.LNX.4.44.0304101658030.7560-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0304110214180.5042-100000@serv>
References: <Pine.LNX.4.44.0304101658030.7560-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Apr 2003, David Lang wrote:

> nobody has claimed that MAKEDEV and similar wouldn't need to be changed,
> just that changing them is not a major deal, and is far less work then
> implementing dynamic numbering.

Dynamic numbering is simple (scsi does it already), the big problem is to 
manage a large number of devices in a scalable way and keeping as much as 
possible dynamic actually helps here.

bye, Roman


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTLPMvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 07:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTLPMvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 07:51:08 -0500
Received: from web13903.mail.yahoo.com ([216.136.175.29]:1124 "HELO
	web13903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261552AbTLPMvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 07:51:06 -0500
Message-ID: <20031216125103.6301.qmail@web13903.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Tue, 16 Dec 2003 04:51:03 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: RAID-0 read perf. decrease after 2.4.20
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 13:47, Marcelo Tosatti wrote:

Hi Marcelo,

> 2.4.20-aa included rmap and some VM modifications most notably
> "drop_behind()" logic which I believe should be the reason for the
huge
> read speedups. Can you please try it? Against 2.4.23.

 Just some feedback:

echo 511 > /proc/sys/vm/max-readahead

 brings back the read performance of my 30 disks on 4 controller
LVM/RAID0.

Cheers
Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUC3Si0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUC3Si0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:38:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:57219 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263809AbUC3SiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:38:20 -0500
Date: Tue, 30 Mar 2004 13:40:34 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Max file size on ext3?
In-Reply-To: <200403302011.52322.rjwysocki@sisk.pl>
Message-ID: <Pine.LNX.4.53.0403301334110.7437@chaos>
References: <200403302011.52322.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004, R. J. Wysocki wrote:

> Can you tell me, please, what the file size limit on ext3 is (should be, if
> any)?
>

Depends upon the block size.

Block size		file size
1 kb			16 GB
2 kb			256 GB
4 kb			2048 GB
8 kb			2048 GB

Linux 2.4 limits single block device sizes to 2 TB.

Extracted from some information by haversain-ga on google.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTJFInW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJFInW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:43:22 -0400
Received: from big.switch.gts.cz ([195.39.57.241]:65154 "EHLO
	big.switch.gts.cz") by vger.kernel.org with ESMTP id S262775AbTJFInV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:43:21 -0400
Date: Mon, 6 Oct 2003 10:43:19 +0200
From: Petr Cisar <pc@big.switch.gts.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Problems with SCSI tape in 2.6.0-test6
Message-ID: <20031006084319.GA7360@big.switch.gts.cz>
Reply-To: Petr Cisar <pc@gts.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I tried to use Compaq SDT-10000 tape drive with the lastest kernel, but I am getting these messages in kernel log:

st0: Failed to read 10240 byte block with 1024 byte transfer.

and it results in ENOMEM returned by read(). I haven't tried this type of tape under any other kernel version, but according to what I found on the net, it should work fine.

Thanks for all comments

Petr Cisar

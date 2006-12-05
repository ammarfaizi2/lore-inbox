Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968613AbWLESmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968613AbWLESmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968615AbWLESmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:42:42 -0500
Received: from hera.kernel.org ([140.211.167.34]:60350 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968613AbWLESml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:42:41 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: skge 2.6.19 UDP checksum error
Date: Tue, 5 Dec 2006 10:42:03 -0800
Organization: OSDL
Message-ID: <20061205104203.2c500d84@freekitty>
References: <457548E7.4050702@dgt.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1165344123 31961 10.8.0.54 (5 Dec 2006 18:42:03 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 5 Dec 2006 18:42:03 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 11:24:39 +0100
Wojciech Kromer <wojciech.kromer@dgt.com.pl> wrote:

> I have UDP checksum error in TX frames  on my
>  "Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 
> 13)"
> 
> With sk98lin it works fine.

Need more hardware info, like:
	lspci -vvvx
and 
	dmesg | grep skge

Kernel version?

IPV6?

-- 
Stephen Hemminger <shemminger@osdl.org>

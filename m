Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbUKTX4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUKTX4G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbUKTXwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:52:55 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:24336 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S263200AbUKTXuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:50:35 -0500
Date: Sun, 21 Nov 2004 00:50:32 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041120235029.GA16966@hardeman.nu>
References: <20041120161704.GA14743@hardeman.nu> <20041120201944.GA26240@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041120201944.GA26240@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 09:19:45PM +0100, Jens Axboe wrote:
>On Sat, Nov 20 2004, David Härdeman wrote:
>> So, my question is, is this implemented in the kernel and are there any 
>> userspace tools to set the playback speed?
>
>I don't know of any, but it is trival to write using SG_IO (or just
>CDROM_SEND_PACKET for this simple use, since only a trivial amount of
>data involved). If you are not sure how to do it, let me know and I can
>easily write one in minutes.

If you could write up a quick-n-dirty tool, it would be great! Based 
on that I could hopefully write a patch later for one of the common
tools (eg. hdparm or setcd).

Re¸
David

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbTJGAkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 20:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTJGAkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 20:40:09 -0400
Received: from intra.cyclades.com ([64.186.161.6]:20921 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261761AbTJGAkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 20:40:06 -0400
Date: Mon, 6 Oct 2003 21:39:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: elmer@linking.ee
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: softraid,ext3 lockup
In-Reply-To: <47897.195.80.106.123.1065189072.squirrel@mail.linking.ee>
Message-ID: <Pine.LNX.4.44.0310062138350.1556-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Oct 2003 elmer@linking.ee wrote:

> 
> 2.4.22 this time, on Xeon x335, / is raid1+ext3, journal size=128M
> 
> dd if=/dev/zero of=/tmp/jama bs=1M count=1000
> 
> on other softraid servers I have, this gets load to 3-4 , performance is
> bad, the same behaviour is present, but tolerable.
> Dual Xeon(exact same HW and conf with 2 cpus) now is about tolerable also
> 
> single  Xeon, with or without ht, still gets very stuck, load goes quickly
> 7-9, ls /directoryNotInCache takes 10 secs, cpu is idle, related processes
> are in D state, as / is on same raid,everything sucks like hell..
> additionally, something that might give a clue: when I mount the partition
> with noatime, load gets quickly to 30...40..50

Weird.

Which kernel does not show this behaviour? 

Thank you


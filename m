Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUJYJFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUJYJFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbUJYJFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:05:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29195 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261706AbUJYJFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:05:11 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] reduce top(1) CPU usage by an order of magnitude
Date: Mon, 25 Oct 2004 12:04:45 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200410251020.01932.vda@port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel> <p73654z8d2j.fsf@verdi.suse.de>
In-Reply-To: <p73654z8d2j.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251204.45940.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 10:35, Andi Kleen wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> 
> > Patch is not mine, Paulo Marques <pmarques@grupopie.com>
> > wrote it.
> 
> The bug is in your top. It shouldn't read /proc/*/wchan
> by default unless the user switches on WCHAN display.
> Just disable that and it will be even faster. My top
> doesn't read it at all, you probably got some buggy
> version.

This is top from procps-2.0.18.
You are right, top may skip reading wchan, I will look into it.
However, if I do request WCHAN, I still want top to be fast.
 
> Also btw we normally let people submit their patches themselves.

I just wanted to prevent this patch from being missed.
--
vda


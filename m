Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265272AbUADKXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 05:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUADKXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 05:23:38 -0500
Received: from vitelus.com ([64.81.243.207]:8900 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S265272AbUADKXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 05:23:37 -0500
Date: Sun, 4 Jan 2004 02:23:13 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Armin <Zoup@zoup.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crazy Mouse !
Message-ID: <20040104102313.GB15838@vitelus.com>
References: <200401041241.26368.Zoup@zoup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401041241.26368.Zoup@zoup.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 12:41:26PM -0900, Armin wrote:
> Hi list , 
> im using 2.6.1-rc1 , i have an ps2 mouse ( in fact , its touch pad ! but iv 
> got this problem with external mouse too ) , when my box is under heavy ( or 
> normal ) load , mouse start to be crazy , dancing all around the screen and 
> click every where ... how can i fix it ? 

I had the same problem, and I solved it, but I'm afraid my solution
probably won't help. I cleaned the blocked ventilation paths in my
laptop and haven't experienced the problem since. I think it was
overheating under load, even with SpeedStep.

I'm not sure why too much heat would cause this problem when it never
caused other weird behavior. Maybe some speed throttling or other
unusual activity was preventing IRQ's from being handled correctly.

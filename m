Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTGTFno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 01:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTGTFnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 01:43:43 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:29195 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S261944AbTGTFnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 01:43:43 -0400
Date: Sun, 20 Jul 2003 15:58:13 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Sean Neakums <sneakums@zork.net>
cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
In-Reply-To: <6uk7aeab33.fsf@zork.zork.net>
Message-ID: <Mutt.LNX.4.44.0307201552580.22965-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003, Sean Neakums wrote:

> twenty.  The problem seems unrelated to the amount of data
> transferred; I've tried both bulk rsync transfers and ssh sessions.
> I've also tested the same boxes over 100baseT; still happens.

It sounds a bit like a pmtu problem related to the wireless bridge, but 
that would be dependent on amount of data transferred and should not 
happen on 100baseT.

Transport mode (just blowfish encryption) looks to be working ok for me,
I'm able to ftp uncompressed kernel tarballs between two boxes over 
gigabit ethernet with no apparent problems.



- James
-- 
James Morris
<jmorris@intercode.com.au>



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbTGUAWL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 20:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbTGUAWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 20:22:11 -0400
Received: from zork.zork.net ([64.81.246.102]:29825 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S269107AbTGUAWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:22:10 -0400
To: James Morris <jmorris@intercode.com.au>
Cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
References: <Mutt.LNX.4.44.0307211026210.25753-100000@excalibur.intercode.com.au>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: James Morris <jmorris@intercode.com.au>,
 netdev@oss.sgi.com,  <linux-kernel@vger.kernel.org>
Date: Mon, 21 Jul 2003 01:37:05 +0100
In-Reply-To: <Mutt.LNX.4.44.0307211026210.25753-100000@excalibur.intercode.com.au> (James
 Morris's message of "Mon, 21 Jul 2003 10:28:09 +1000 (EST)")
Message-ID: <6uu19g67gu.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@intercode.com.au> writes:

> On Sun, 20 Jul 2003, Sean Neakums wrote:
>
>> > With the 100baseT configuration, are the systems on the same segment?
>> 
>> I'm connecting the two machines with a crossed-over cable.
>
> I can't see anything strange here.  Can you confirm that you are seeing 
> the pmtu messages for the crossover cable case?  If not, perhaps try 
> manual configuration to rule out any racoon issues.

Yes.  I checked the logs after I did the recreation, and the pmtu
messages are definitely showing up in the crossover case.  Will retry
with manual config.


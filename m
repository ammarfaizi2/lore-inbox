Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTFOTb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTFOTb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:31:28 -0400
Received: from franka.aracnet.com ([216.99.193.44]:17358 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262771AbTFOTb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:31:27 -0400
Date: Sun, 15 Jun 2003 12:45:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: fire-eyes <sgtphou@fire-eyes.dynup.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 / 2.5.71 - Problem at Uncompressing Linux... OK
Message-ID: <472000000.1055706315@[10.10.2.4]>
In-Reply-To: <1055704091.10275.22.camel@fire-eyes>
References: <1055704091.10275.22.camel@fire-eyes>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--fire-eyes <sgtphou@fire-eyes.dynup.net> wrote (on Sunday, June 15, 2003 15:08:11 -0400):

> I am just beginning to experiment with 2.5, my appologies if I have
> missed something. If there are other resources that could have answered
> this question, I eagerly await suggestions.
> 
> With both 2.5.70 and 2.5.71, when the machine boots, it gets to
> "Uncompressing Linux... OK", and then it stops there. Disk activity is
> clearly still going on. After a short time, I can ping it, or other
> network activity. If I try to ssh into it, I am asked my password. After
> hitting enter, nothing happens. I can try this repeatedly to no avail.
> 
> Am I missing something fundamental here?
> 
> Thank you for your time.
> 
> 
> Please CC me, as I am not (yet?) subscribed to the list

Make sure CONFIG_INPUT and the VT console stuff are both "Y".
Else, try grabbing this:

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.5.71/2.5.71-mjb1/100-early_printk

read the top of the patch to see how to turn it on, and try again ...

M.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136092AbRECAwF>; Wed, 2 May 2001 20:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136097AbRECAvz>; Wed, 2 May 2001 20:51:55 -0400
Received: from mail.intrex.net ([209.42.192.246]:8199 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S136092AbRECAvh>;
	Wed, 2 May 2001 20:51:37 -0400
Date: Wed, 2 May 2001 20:52:02 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel
Message-ID: <20010502205202.A18296@bessie.localdomain>
In-Reply-To: <65256A40.00441BB5.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <65256A40.00441BB5.00@sandesh.hss.hns.com>; from alad@hss.hns.com on Wed, May 02, 2001 at 06:00:00PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 06:00:00PM +0530, alad@hss.hns.com wrote:

> suppose I am making some change in sched.c and now I want to build my kernel
> that reflects the change..
> Is there any way I can avoid answering all the questions when I do make zImage ?
> 
> In short how should I compile the kernel (in very small time) to see my changes.

It sounds like you are running "make config" after you make your changes.
If you run "make oldconfig" instead of "make config" it will not ask you
questions unless you have added config options to the configure scripts.

Its probably not necessary to run either on of these if you have just made
minor changes to the code.  It does not hurt to do it though, and 
"make oldconfig" is fast.

Hope this helps,

Jim

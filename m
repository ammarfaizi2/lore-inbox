Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbTFAPyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 11:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264657AbTFAPyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 11:54:09 -0400
Received: from mail.coastside.net ([207.213.212.6]:60059 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP id S264652AbTFAPyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 11:54:08 -0400
Mime-Version: 1.0
Message-Id: <p05210609baffd3a79cfb@[207.213.214.37]>
In-Reply-To: <20030601140602.GA3641@work.bitmover.com>
References: <1054446976.19557.23.camel@spc>
 <20030601132626.GA3012@work.bitmover.com>
 <20030601134942.GA10750@alpha.home.local>
 <20030601140602.GA3641@work.bitmover.com>
Date: Sun, 1 Jun 2003 09:04:22 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Question about style when converting from K&R to ANSI C.
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:06am -0700 6/1/03, Larry McVoy wrote:
>It may be just what you are used to but I also find that when reading lots
>of code it is nice to have it look like
>
>return type
>function_name(args)
>
>because the function_name() stands out more, it's always at the left side so
>I tend to parse it a little more quickly.

The reason I've liked this format is that it gives me a quick and 
universal way to find *specific* functions with vi or grep, by 
searching for "^function_name(".

I'm less concerned with global function searches; there I don't mind 
the overhead of more sophisticated tools.

When we're done with this thread, perhaps we can return to endian arguments....
-- 
/Jonathan Lundell.

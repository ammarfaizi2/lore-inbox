Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271149AbTG1VPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271150AbTG1VPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 17:15:10 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:49346 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271149AbTG1VOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 17:14:25 -0400
Message-ID: <3F25761D.5030602@cornell.edu>
Date: Mon, 28 Jul 2003 15:14:37 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030721 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonas Bofjall <j-lnxk@gazonk.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: FYI: TCQ ReiserFS Corruption on 2.6.0-test1-mm2
References: <Pine.LNX.4.51.0307281231590.29434@gazonk.org>
In-Reply-To: <Pine.LNX.4.51.0307281231590.29434@gazonk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonas Bofjall wrote:
> I use an IBM Deskstar 180GB IDE disk and tried out TCQ on 2.6.0-test1-mm2.
> I have a VIA IDE interface on my A7V8X motherboard. This corrupted my
> ReiserFS file system, just by running the same reiserfsck utility that
> works well without TCQ. So at least on this disk/controller, IDE-TCQ
> probably doesn't work well.

What TCQ queue depth?
I'm curious, since I had *exactly* the same happen to me, but only
with depth 8 queue. Wondering if there is a connection....



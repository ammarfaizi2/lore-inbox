Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbTIDQ2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTIDQ2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:28:53 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:34504 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265192AbTIDQ2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:28:09 -0400
Date: Thu, 4 Sep 2003 12:25:16 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "David S. Miller" <davem@redhat.com>
cc: "YOSHIFUJI Hideaki / _$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: /proc/net/* read drops data
In-Reply-To: <20030904004638.1d4b001d.davem@redhat.com>
Message-ID: <Pine.GSO.4.33.0309041223430.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, David S. Miller wrote:
>> D: Fixing a bug that reading /proc/net/{udp,udp6} may drop some data
>
>This fix looks good to me.  Applied.

The list:
(file)			(bs=1)	(bs=10000)
/proc/net/igmp		122     191
/proc/net/route		128     384
/proc/net/rt_acct	0	4096
/proc/net/rt_cache	384     512
/proc/net/tcp		1800    1950
/proc/net/udp		1024    1152

(I don't have ipv6 enabled)

--Ricky



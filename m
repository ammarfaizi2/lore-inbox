Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSJVEsS>; Tue, 22 Oct 2002 00:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbSJVEsS>; Tue, 22 Oct 2002 00:48:18 -0400
Received: from pcp470010pcs.westk01.tn.comcast.net ([68.47.207.140]:2717 "EHLO
	shed.7house.org") by vger.kernel.org with ESMTP id <S262197AbSJVEsR>;
	Tue, 22 Oct 2002 00:48:17 -0400
Message-ID: <3DB4D9F8.F86ABA4@y12.doe.gov>
Date: Tue, 22 Oct 2002 00:54:16 -0400
From: David Dillow <dillowd@y12.doe.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Keller <cnkeller@interclypse.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3COM 3C990 NIC
References: <1035002976.3086.4.camel@maranello.interclypse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Keller wrote:
> Is anyone maintaining the 3C990 driver? I'm using the code from 3COM and
> it doesn't look like it's been kept up to date with the various kernel
> changes. I'm also using the latest Red Hat kernel in case it matters.

I have a completely reworked version that I expect to be able to release RSN.
(I know, I know, some of you have heard that before... it just takes time to
get people around here to sign off on these things. :/)

It will support zero-copy TCP, TCP segmentation offload, and when DaveM's
IPSEC is in, I'll be able to do hardware offload for that as well.

D

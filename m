Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUCNS1f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUCNS1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:27:34 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:10381 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S261935AbUCNS1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:27:34 -0500
Message-ID: <4054A3BD.1000706@BitWagon.com>
Date: Sun, 14 Mar 2004 10:26:05 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <20040311141703.GE3053@luna.mooo.com>	 <1079198671.4446.3.camel@laptop.fenrus.com>	 <20040313221018.GE5960@luna.mooo.com> <1079217685.4915.2.camel@laptop.fenrus.com>
In-Reply-To: <1079217685.4915.2.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The internal kernel HZ should *NOT* leak out to usespace.

/proc/interrupts "leaks" the value of HZ.  On x86, for instance:
    ( cat /proc/interrupts; sleep 5; cat /proc/interrupts )  |  grep timer

-- 



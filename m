Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUD0Pyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUD0Pyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUD0Pyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:54:55 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:62988 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261763AbUD0Pyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:54:54 -0400
Message-ID: <408E833C.6030808@techsource.com>
Date: Tue, 27 Apr 2004 11:58:52 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: karim@opersys.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hand with radeon 9000 / AGP / DRI
References: <408B7DA4.7010101@opersys.com>
In-Reply-To: <408B7DA4.7010101@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Karim Yaghmour wrote:
> 
> I've been playing around trying to get the most out of my Radeon
> 9000 pro with a 2.4.x kernel and I must admit that I've been
> somewhat disapointed. There are two things I've been trying to get
> to work properly:
> 1) RadeonFB
> 2) Direct rendering in X (needs DRI and AGP)
> 


Which driver are you using for OpenGL?  The x11 (mesa) driver, or ATI's 
driver?  ATI's driver doesn't play nice with radeonfb.

Also, telling radeonfb what resolution you want on the boot command line 
is broken if the res you request and the res reported by EDID disagree.


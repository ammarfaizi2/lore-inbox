Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264767AbUEYNi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbUEYNi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 09:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUEYNi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 09:38:29 -0400
Received: from zero.aec.at ([193.170.194.10]:45829 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264767AbUEYNiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 09:38:18 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI Express patches for 2.4.27-pre3
References: <1ZuS0-1b4-15@gated-at.bofh.it> <1ZE52-8sy-15@gated-at.bofh.it>
	<1ZFaF-10N-13@gated-at.bofh.it> <1ZIrV-3xS-7@gated-at.bofh.it>
	<1ZJHt-4At-33@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 25 May 2004 15:38:11 +0200
In-Reply-To: <1ZJHt-4At-33@gated-at.bofh.it> (Marcelo Tosatti's message of
 "Tue, 25 May 2004 15:00:19 +0200")
Message-ID: <m31xl839vg.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

>
> major? the MMConfig support is minimal as I can see? 
>
>> > Marcelo, feel free to tell me otherwise if you do not want
>> > this in the 2.4 tree. 
>
> Is this code necessary for PCI-Express devices/busses to work properly?

No, it is completely optional right now.

Also we found that it sometimes triggers bugs that are not happening
with old style config space accesses. 

-Andi


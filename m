Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTKRQ6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTKRQ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:58:17 -0500
Received: from terminus.zytor.com ([63.209.29.3]:52964 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263711AbTKRQ6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:58:16 -0500
Message-ID: <3FBA4F9B.20203@zytor.com>
Date: Tue, 18 Nov 2003 08:58:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube.suse.lists.linux.kernel>	<20031111133859.GA11115@bitwizard.nl.suse.lists.linux.kernel>	<20031111085323.M8854@devserv.devel.redhat.com.suse.lists.linux.kernel>	<bp0p5m$lke$1@cesium.transmeta.com.suse.lists.linux.kernel>	<20031113233915.GO1649@x30.random.suse.lists.linux.kernel>	<3FB4238A.40605@zytor.com.suse.lists.linux.kernel>	<20031114011009.GP1649@x30.random.suse.lists.linux.kernel>	<3FB42CC4.9030009@zytor.com.suse.lists.linux.kernel> <p734qx7rmyf.fsf@oldwotan.suse.de>
In-Reply-To: <p734qx7rmyf.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> That would be buggy because existing users of sendfile don't know
> about this and would silently only copy part of the file when a signal
> happens.
> 

It would be consistent with the documented semantics for other file 
operations.  Obviously, return zero only on EOF.

	-hpa


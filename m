Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264466AbTKNBQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 20:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTKNBQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 20:16:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1809 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264466AbTKNBQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 20:16:38 -0500
Message-ID: <3FB42CC4.9030009@zytor.com>
Date: Thu, 13 Nov 2003 17:15:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
References: <1068512710.722.161.camel@cube> <20031111133859.GA11115@bitwizard.nl> <20031111085323.M8854@devserv.devel.redhat.com> <bp0p5m$lke$1@cesium.transmeta.com> <20031113233915.GO1649@x30.random> <3FB4238A.40605@zytor.com> <20031114011009.GP1649@x30.random>
In-Reply-To: <20031114011009.GP1649@x30.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Thu, Nov 13, 2003 at 04:36:26PM -0800, H. Peter Anvin wrote:
> 
>>... or we could put in checks into the kernel for signal pending, and
>>return EINTR.
> 
> that would be even better indeed.
>

s/EINTR/short count/, of course :)

	-hpa


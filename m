Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbWAHSWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbWAHSWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 13:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWAHSWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 13:22:36 -0500
Received: from quark.didntduck.org ([69.55.226.66]:28383 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932737AbWAHSWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 13:22:34 -0500
Message-ID: <43C158CD.6000008@didntduck.org>
Date: Sun, 08 Jan 2006 13:24:13 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: rusty@rustcorp.com.au, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: Fix typo
References: <43C13593.6080509@didntduck.org> <20060108174537.GC10990@mars.ravnborg.org>
In-Reply-To: <20060108174537.GC10990@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Sun, Jan 08, 2006 at 10:53:55AM -0500, Brian Gerst wrote:
>> SND_MAX should be FF_MAX
>>
>> Signed-off-by: Brian Gerst <bgerst@didntduck.org>
> 
> Applied, though I have not found a way to actually check this one is
> correct.
> 

id->ffbit is defined as kernel_ulong_t ffbit[FF_MAX/BITS_PER_LONG+1]

--
				Brian Gerst

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTANNEM>; Tue, 14 Jan 2003 08:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTANNEL>; Tue, 14 Jan 2003 08:04:11 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:43734 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S262789AbTANNEL>; Tue, 14 Jan 2003 08:04:11 -0500
Message-ID: <3E240CEB.8070301@quark.didntduck.org>
Date: Tue, 14 Jan 2003 08:13:15 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: anyone have a 16-bit x86 early_printk?
References: <20030114113036.GG940@holomorphy.com>
In-Reply-To: <20030114113036.GG940@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> I'm trying to get a box to boot and it appears to drop dead before
> start_kernel(). Would anyone happen to have an early_printk() analogue
> for 16-bit x86 code?

It could be failing in the decompression routine if it was compiled for 
the wrong cpu (ie. using cmov instructions).

--
				Brian Gerst



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUBIH3l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 02:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUBIH3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 02:29:41 -0500
Received: from terminus.zytor.com ([63.209.29.3]:61580 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262827AbUBIH3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 02:29:39 -0500
Message-ID: <402736D6.4000502@zytor.com>
Date: Sun, 08 Feb 2004 23:29:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: David Weinehall <david@southpole.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
References: <c07c67$vrs$1@terminus.zytor.com> <20040209072137.GU5776@khan.acc.umu.se>
In-Reply-To: <20040209072137.GU5776@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> 
>>Hi all,
>>
>>Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
>>thinking of restructuring the pty system slightly to make it more
>>dynamic and to make use of the new larger dev_t, and I'd like to get
>>rid of the BSD ptys as part of the same patch.
> 
> As long as you make it a 2.7-thing, I don't thing anyone would mind
> much...
> 

Right, this is basically for 2.6/2.7 depending on if there are any 
stragglers who still use these things...

	-hpa

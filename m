Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753841AbWKFWCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbWKFWCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbWKFWCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:02:30 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:47414 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1753841AbWKFWC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:02:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uSvhznT95foEHMCIKNtlUJBGoeG/31BwOpFmBMVsgpF/Wd4+PWNQWBJ2ZY0kOc37pP/rM7L0aB14qqYrSwgWxvIcrhDZ9snvy21+z4RRqqHdrkqhyTv23UVV92NFmmkWUrg88Cht4LONa32C25h9DgFla16/2lbuoonT/sFVUr4=
Message-ID: <610823610611061402g1d7811abhbf2479fa63f2970d@mail.gmail.com>
Date: Mon, 6 Nov 2006 17:02:26 -0500
From: "Andrew Wade" <andrew.j.wade@gmail.com>
Reply-To: ajwade@alumni.uwaterloo.ca
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Subject: Re: 2.6.19-rc4-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Kimball Murray" <kimball.murray@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A040@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A040@EXNA.corp.stratus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com> wrote:
> What's the device id of your VC1?

I presume lscpi -n -v will tell you what you need to know. I don't know
how to read the output myself:

0000:01:00.0 0300: 1002:5157
        Subsystem: 1002:013a
        Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 16
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

My card is a dual-head card, but I'm only using one head. On that head, if
I switch to virtual console 1, everything is fine, but if I switch to any
other vitual console, the display is "garbled": each row of pixels is offset
from the row before, producing interlaced "ghost" images.

I hope this helps; feel free to ask further questions.

-ajw

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWIATg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWIATg0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 15:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWIATg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 15:36:26 -0400
Received: from pih-relay05.plus.net ([212.159.14.132]:43449 "EHLO
	pih-relay05.plus.net") by vger.kernel.org with ESMTP
	id S1751223AbWIATgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 15:36:25 -0400
Message-ID: <44F88B98.3020805@mauve.plus.com>
Date: Fri, 01 Sep 2006 20:35:52 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Helge Hafting <helge.hafting@aitel.hist.no>, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org, linux-tiny@selenic.com, devel@laptop.org
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
References: <1156429585.3012.58.camel@pmac.infradead.org>	 <1156433068.3012.115.camel@pmac.infradead.org>	 <200608251611.50616.rob@landley.net>	 <1156538115.3038.6.camel@pmac.infradead.org>	 <44F2CB09.2010809@aitel.hist.no> <1156764076.5340.75.camel@pmac.infradead.org>
In-Reply-To: <1156764076.5340.75.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Mon, 2006-08-28 at 12:52 +0200, Helge Hafting wrote:
>> And a "make optImage" (optimized image) when building a
>> kernel for production use, when you believe compiling every file
>> and spending lots of extra time is worth it. 
<snip>
> But if, as I suggest, we're doing the simple option which combines only
> the files which tend to get most benefit from it -- those which are in
> the same directory -- then there's not a lot of point in the separate
> target. It really doesn't take that much extra time.

I thought that it used rather a lot more RAM. I still often(ish) compile 
a kernel on my PII/300/128M. It'd be moderately annoying if it got 
slower, and there was no way to turn it off.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWFAQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWFAQzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWFAQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:55:04 -0400
Received: from dvhart.com ([64.146.134.43]:1939 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1030237AbWFAQzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:55:02 -0400
Message-ID: <447F1BE4.5040705@mbligh.org>
Date: Thu, 01 Jun 2006 09:55:00 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Martin J. Bligh" <mbligh@google.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org> <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org> <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org> <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com> <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com> <20060531225013.GA7125@elte.hu> <Pine.LNX.4.64.0606011222230.17704@scrub.home> <447EFE86.7020501@google.com> <Pine.LNX.4.64.0606011659030.32445@scrub.home> <447F084C.9070201@google.com> <Pine.LNX.4.64.0606011742500.32445@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606011742500.32445@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 1 Jun 2006, Martin J. Bligh wrote:
> 
> 
>>Did you read the discussion that lead up to it? I thought that quite
>>clearly described why such a thing was needed.
> 
> 
> I did read it, what did I miss?

So the point is to enable the performance-affecting debug options by
default, but provide one clear hook to turn them all off, with a name
that's consistent over time, so we can do it in an automated fashion.

To me that means having clear name so people know which option to hook
stuff under, and preferably not hiding stuff behind extra config options
to make them harder to find. Maybe I've missed the point of what you
were trying to do, but it seemed to not meet that.

M.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281834AbRK1Ats>; Tue, 27 Nov 2001 19:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281825AbRK1Ati>; Tue, 27 Nov 2001 19:49:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:28687 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281834AbRK1At0>; Tue, 27 Nov 2001 19:49:26 -0500
Message-ID: <3C043468.D50998E@zip.com.au>
Date: Tue, 27 Nov 2001 16:48:40 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Torrey Hoffman <torrey.hoffman@myrio.com>
CC: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CAE0@mail0.myrio.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman wrote:
> 
> I've running 2.4.16 with this VM patch combined with your
> 2.4.15-pre7-low-latency patch from www.zip.com.au.  (it applied with a
> little fuzz, no rejects). Is this a combination that you would feel
> comfortable with?

Should be OK.  There is a possibility of livelock when you have
a lot of dirty buffers against multiple devices.  It may
be a good idea to pick up the 2.4.16 low-latency patch.
http://www.zip.com.au/~akpm/linux/2.4.16-low-latency.patch.gz

> So far it hasn't blown up on me, and in fact seems very quick and
> responsive.
> 
> Unless I hear a "No, don't do that!", I'm going to push this kernel into
> testing for our video applications...

If any quantitative results become available, please share...

-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287602AbSALW0r>; Sat, 12 Jan 2002 17:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287599AbSALW0h>; Sat, 12 Jan 2002 17:26:37 -0500
Received: from ns.ithnet.com ([217.64.64.10]:39429 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287602AbSALW0e>;
	Sat, 12 Jan 2002 17:26:34 -0500
Date: Sat, 12 Jan 2002 23:26:17 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org,
        linux-audio-dev@music.columbia.edu
Subject: Re: [PATCH] Additions to full lowlatency patch
Message-Id: <20020112232617.1f31bb72.skraw@ithnet.com>
In-Reply-To: <3C40AF23.18C811A8@kolumbus.fi>
In-Reply-To: <3C40AF23.18C811A8@kolumbus.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002 23:48:19 +0200
Jussi Laako <jussi.laako@kolumbus.fi> wrote:

> Hi,
> 
> I've done some changes to lowlatency patched kernel. Mainly "fixes" to DRM
> drivers and few network drivers. Most probably I have done something really
> stupid, but those work here(tm). Especially the Radeon driver patch has got
> a lot of testing and seems to have huge impact to latencies in my system.

That leaves us with just about another 4000 source files in the tree to fill up
with conditional_schedule()s. If we made that up, we should start talking about
a single event queue throughout the kernel, because this is a very successful
and unbelievably elegant piece of software design found in the market of OSs
either. :-(

You are just kidding, aren't you?

Regards,
Stephan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSLJAgV>; Mon, 9 Dec 2002 19:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266462AbSLJAgV>; Mon, 9 Dec 2002 19:36:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42255 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266460AbSLJAgT>; Mon, 9 Dec 2002 19:36:19 -0500
Date: Mon, 9 Dec 2002 19:42:23 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dazed and Confused
In-Reply-To: <at2qck$ffi$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.3.96.1021209193548.9066A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Dec 2002, H. Peter Anvin wrote:

> The fact that you're seeing the error means data corruption has
> already occurred.

Maybe. The fact that the error is noticed indicates that the memory has at
least parity capability. However, current memory with has "by 72" width
instead of "by 64" can also do EDAC, in which case all one bit errors will
be corrected. Some motherboards can be configured to NMI on parity, even
if corrected. I had one, back when PPro was hot stuff.

So it's just possible that the data is fine in spite of the NMI. That
said, I'd start looking for a hardware problem regardless, even if it's
currently working, it's not working *right*.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


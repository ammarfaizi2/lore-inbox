Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313669AbSDTA3b>; Fri, 19 Apr 2002 20:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314137AbSDTA3a>; Fri, 19 Apr 2002 20:29:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17669 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313669AbSDTA3a>; Fri, 19 Apr 2002 20:29:30 -0400
Date: Fri, 19 Apr 2002 17:29:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: bgerst@didntduck.org, <andrea@suse.de>, <ak@suse.de>,
        <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <3604.131.107.184.74.1019261941.squirrel@www.zytor.com>
Message-ID: <Pine.LNX.4.44.0204191727210.6542-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Apr 2002, H. Peter Anvin wrote:
>
> Remember that one of the original design goals of MMX was to run on
> unmodified operating systems (and it can't be turned off); thus needing
> any extra initialization is a bug.

Oh, I agree 100%. The sanest thing would certainly have been to make sure
"fninit" just clears everything inclusing MMX and full XMM state. Oh,
well.

		Linus


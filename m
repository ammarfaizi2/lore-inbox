Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317667AbSGUIvE>; Sun, 21 Jul 2002 04:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317668AbSGUIvE>; Sun, 21 Jul 2002 04:51:04 -0400
Received: from mta04ps.bigpond.com ([144.135.25.136]:30963 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317667AbSGUIvE>; Sun, 21 Jul 2002 04:51:04 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code v3
Date: Sun, 21 Jul 2002 18:49:55 +1000
User-Agent: KMail/1.4.5
References: <20020719011300.548d72d5.arodland@noln.com> <20020720173222.3286fcbb.arodland@noln.com>
In-Reply-To: <20020720173222.3286fcbb.arodland@noln.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207211849.56076.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jul 2002 07:32, Andrew Rodland wrote:
> Yes, I actually _am_ trying to turn this into something useful.
> Now, I don't have a 2.5 tree, and probably wouldn't understand it if I
> did, but I get a feeling that this won't be so incredibly easy to port,
> thanks to having everything use the input layer. Or am I wrong?

While it will be non-trivial, it won't be hard either.
The advantage of the input layer is that it no longer matters what
type of keyboard is attached - you can just call input_event() and
turn on and off the LED. The input layer abstracts out the magic
values needed for any particular keyboard.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.

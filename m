Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272671AbRHaMCO>; Fri, 31 Aug 2001 08:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272672AbRHaMCE>; Fri, 31 Aug 2001 08:02:04 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:16380 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S272671AbRHaMBv>;
	Fri, 31 Aug 2001 08:01:51 -0400
Date: Fri, 31 Aug 2001 14:01:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108302327.f7UNRvl04257@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.33.0108311342570.24131-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 31 Aug 2001, Peter T. Breuer wrote:

>    if (sizeof(_x) != sizeof(_y)) \
>      MIN_BUG(); \

What bug are you trying to fix here?

> int main() {
>   unsigned i = 1;
>   signed j = -2;
>   return MIN(i,j);
> }

Try -Wsign-compare.

bye, Roman





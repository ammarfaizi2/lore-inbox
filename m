Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271699AbRHQVDm>; Fri, 17 Aug 2001 17:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271595AbRHQVDd>; Fri, 17 Aug 2001 17:03:33 -0400
Received: from camus.xss.co.at ([194.152.162.19]:10763 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S271659AbRHQVDS>;
	Fri, 17 Aug 2001 17:03:18 -0400
Message-ID: <3B7D8685.FE574210@xss.co.at>
Date: Fri, 17 Aug 2001 23:03:01 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S - *x Software + Systeme
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Bulent Abali <abali@us.ibm.com>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Swapping for diskless nodes
In-Reply-To: <Pine.LNX.4.33L.0108162146120.5646-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Rik van Riel wrote:
> 
> On Thu, 16 Aug 2001, Pavel Machek wrote:
> 
> > I'd call that configuration error. If swap-over-nbd works in all but
> > such cases, its okay with me.
> 
> Agreed. I'm very interested in this case too, I guess we
> should start testing swap-over-nbd and trying to fix things
> as we encounter them...
> 
As I promised a few days ago I have just released the newest 
version of our NBD swap patches for Linux-2.2.19.
You can find them together with the NBD swap server and
client source code under the following URL:

<ftp://ftp.xss.co.at/pub/Linux/NBD/nbdswap-1.2-1.tar.gz>

It works for us, and we think it works reasonably well.
YMMV, though. Please check it out and tell us what you
think. We would really like to see something like this
to be included in Linux-2.5.

Suggestions, improvements and ideas are welcome.

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264515AbRFYWnL>; Mon, 25 Jun 2001 18:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264523AbRFYWnB>; Mon, 25 Jun 2001 18:43:01 -0400
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:33416 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S264515AbRFYWmr>; Mon, 25 Jun 2001 18:42:47 -0400
Date: Tue, 26 Jun 2001 00:41:49 +0200
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Fabian Arias <dewback@vtr.net>, Anuradha Ratnaweera <anuradha@gnu.org>,
        Anatoly Ivanov <avi@levi.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 and gcc v3 final
Message-ID: <20010626004149.A3310@storm.local>
Mail-Followup-To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Fabian Arias <dewback@vtr.net>,
	Anuradha Ratnaweera <anuradha@gnu.org>,
	Anatoly Ivanov <avi@levi.spb.ru>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200106241733.f5OHXpW2000565@sleipnir.valparaiso.cl>
User-Agent: Mutt/1.3.18i
From: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 01:33:51PM -0400, Horst von Brand wrote:
> What gcc objects to is stuff like:
> 
>    "This is a nice long string
>     that just goes on
>     and on\n"
> 
> which is illegal in C AFAIU. It does not object to:
> 
>    "This long string"
>    "spans several lines, "
>    "but legally.\n"

But the first example contains three newlines, the second just one.  A
thing to keep in mind when going around fixing these multi line strings,
explicit newlines have to be added.

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44

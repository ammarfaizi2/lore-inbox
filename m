Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131172AbRAKHP3>; Thu, 11 Jan 2001 02:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131513AbRAKHPU>; Thu, 11 Jan 2001 02:15:20 -0500
Received: from ns1.megapath.net ([216.200.176.4]:9746 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S131172AbRAKHPC>;
	Thu, 11 Jan 2001 02:15:02 -0500
Message-ID: <3A5D5CFC.5080309@megapathdsl.net>
Date: Wed, 10 Jan 2001 23:13:00 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac1 i686; en-US; m18) Gecko/20010107
X-Accept-Language: en
MIME-Version: 1.0
To: jga@wastelandranger.org
CC: linux-kernel@vger.kernel.org
Subject: Re: PPP: VJ decompression error
In-Reply-To: <Pine.LNX.4.31.0101110039350.3216-100000@wastelandranger.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Anthony wrote:

> Ok, I just upgraded to 2.4.0 from 2.2.17 and I get a slew of these "PPP:
> VJ decompression error" messages in my kern.log. I have searched all over
> the place for a patch or an answer, but find nothing. These messages show
> up mostly when I use Netscape, if that helps.

I complained about this ages ago and submitted snippets of PPP
debug output for analysis.  As I recall, the problem was never
resolved and I wound up simply putting "novj" in my PPP config
file:

    /etc/ppp/options

If you'd like to pursue this further, there is a linux-ppp mailing list:

	linux-ppp@vger.kernel.org

I believe this is the PPP maintainer's e-mail address:

	Paul Mackerras <paulus@linuxcare.com>

Best of luck,

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130403AbRCEUIn>; Mon, 5 Mar 2001 15:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbRCEUId>; Mon, 5 Mar 2001 15:08:33 -0500
Received: from dawa.demon.co.uk ([194.222.0.39]:12160 "EHLO dawa.demon.co.uk")
	by vger.kernel.org with ESMTP id <S130403AbRCEUIZ>;
	Mon, 5 Mar 2001 15:08:25 -0500
Message-ID: <3AA3F282.BC281C49@dawa.demon.co.uk>
Date: Mon, 05 Mar 2001 20:09:38 +0000
From: Paul Flinders <paul@dawa.demon.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>, Paul Flinders <P.Flinders@ftel.co.uk>,
        Jeff Mcadams <jeffm@iglou.com>, Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov>
			<Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva>
			<20010305105943.A25964@iglou.com> <3AA3BC4E.FA794103@ftel.co.uk> <jeae70m97e.fsf@hawking.suse.de> <3AA3EEDF.D0547D4@dawa.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Flinders wrote:

> uses space (0x20) and tab (0x8) as white space and no other character.
>

<sigh> I mean, of course, tab (_0x9_)

I just checked - the kernel isspace() macro says that \r is whitespace.



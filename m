Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129372AbRCEQBJ>; Mon, 5 Mar 2001 11:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129363AbRCEQA7>; Mon, 5 Mar 2001 11:00:59 -0500
Received: from team.iglou.com ([192.107.41.45]:25311 "EHLO iglou.com")
	by vger.kernel.org with ESMTP id <S129372AbRCEQAq>;
	Mon, 5 Mar 2001 11:00:46 -0500
Date: Mon, 5 Mar 2001 10:59:43 -0500
From: Jeff Mcadams <jeffm@iglou.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
Message-ID: <20010305105943.A25964@iglou.com>
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov> <Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Mar 05, 2001 at 12:25:13PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Rik van Riel
>On Mon, 5 Mar 2001, John Kodis wrote:
>> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
>> > Somebody must have missed the boat entirely. Unix does not, never
>> > has, and never will end a text line with '\r'.

>> Unix does not, never has, and never will end a text line with ' ' (a
>> space character) or with \t (a tab character).  Yet if I begin a
>> shell script with '#!/bin/sh ' or '#!/bin/sh\t', the training white
>> space is striped and /bin/sh gets exec'd.  Since \r has no special
>> significance to Unix, I'd expect it to be treated the same as any
>> other whitespace character -- it should be striped, and /bin/sh
>> should get exec'd.

>Makes sense, IMHO...

That only makes sense if:
#!/bin/shasdf\n
would also exec /bin/sh.

" " and \t are whitespace, \r is not whitespace.
-- 
Jeff McAdams                            Email: jeffm@iglou.com
Head Network Administrator              Voice: (502) 966-3848
IgLou Internet Services                        (800) 436-4456

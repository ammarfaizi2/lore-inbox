Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273993AbRISDVb>; Tue, 18 Sep 2001 23:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273994AbRISDVV>; Tue, 18 Sep 2001 23:21:21 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:29195 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S273993AbRISDVQ>;
	Tue, 18 Sep 2001 23:21:16 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109190320.f8J3KC3272695@saturn.cs.uml.edu>
Subject: Re: Strange ps line
To: flavio@conectiva.com.br (Flavio Bruno Leitner)
Date: Tue, 18 Sep 2001 23:20:12 -0400 (EDT)
Cc: pochini@shiny.it (Giuliano Pochini), linux-kernel@vger.kernel.org
In-Reply-To: <20010917150656.A20241@conectiva.com.br> from "Flavio Bruno Leitner" at Sep 17, 2001 03:06:56 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Bruno Leitner writes:
> On Mon, Sep 17, 2001 at 05:37:00PM +0200, Giuliano Pochini wrote:

>> From "ps axuw":
>> 
>> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
>> httpd     5020  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
>> httpd     5022  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
>> httpd     5025  0.0  0.0 589505315 0 ?       ZL   16:46   0:00 [getcod.cgi <defunct>]
>> httpd     5049  0.0  0.0     0    0 ?        Z    16:46   0:00 [getcod.cgi <defunct>]
>> 
>> That cgi doesn't lock memory and surely I don't have so much memory.
> 
> Look at http://www.erlenstar.demon.co.uk/unix/faq_2.html#SEC14
> maybe this can help you. 

Yes and no. It might solve his zombie problem, but what about that
outrageous VSZ and the locked memory? Useful info would be:

/proc/5025/status
/proc/5025/stat

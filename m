Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUGLQM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUGLQM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUGLQM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:12:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:33510 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266864AbUGLQMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:12:25 -0400
To: Timothy Miller <miller@techsource.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linus Torvalds <torvalds@osdl.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org>
	<40ED7BE7.7010506@techsource.com>
	<200407090056.51084.vda@port.imtp.ilyichevsk.odessa.ua>
	<40F2AB82.40508@techsource.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  Now we can become alcoholics!
Date: Mon, 12 Jul 2004 18:12:23 +0200
In-Reply-To: <40F2AB82.40508@techsource.com> (Timothy Miller's message of
 "Mon, 12 Jul 2004 11:17:22 -0400")
Message-ID: <jeisct2oig.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> writes:

> Denis Vlasenko wrote:
>> The question is, whether readers of your code (including compiler)
>> will be able to be sure that there is no error in
>> 	f(a,b,c,d,e,0,f,g,h);
>> statement or not. Better typecheck that 0.
>
> This I agree with, definately.  It's very important to make your code
> readable, and if it's not obvious from context, make it obvious.  Cases
> like the above are one of the reasons I like languages like Verilog where
> you can pass parameters by specifying the parameter name.

If your function needs nine arguments it is not readable by
definition. :-)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

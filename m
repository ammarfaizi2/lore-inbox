Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278432AbRJSPg3>; Fri, 19 Oct 2001 11:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278436AbRJSPgT>; Fri, 19 Oct 2001 11:36:19 -0400
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:50700 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S278432AbRJSPgM> convert rfc822-to-8bit;
	Fri, 19 Oct 2001 11:36:12 -0400
Date: Fri, 19 Oct 2001 10:38:09 -0500
From: Taral <taral@taral.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
Message-ID: <20011019103809.E30774@taral.net>
In-Reply-To: <3bcef893.4872.0@panix.com> <20011018114921.A30969@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 11:49:21AM -0400, Arjan van de Ven wrote:
> I'm sorry. "module inserting" is LINKING. A kernel module does, in my
> oppinion, NOT fall under the gpl stated "mere aggregation" boundary of the
> GPL, it is compiled with kernel headers, contains kernel _code_ from these
> headers etc etc, and is for all intents and purposes part of the GPL program
> "kernel" once loaded. It uses normal function calls etc etc, symbols are
> resolved using normal linking mechanisms etc etc.

You're quite right. Module insertion is linking. And distributing a
kernel with binary-only modules already inserted would be a GPL
violation. What modules do is let people do the link at the last stage
-- the end user. The GPL does not restrict what end-users do with your
code if it doesn't involve redistribution.

In short: Copyright holders have the right to attempt to restrict their
interfaces. But end-users also have the right to ignore those attempts.
That is, unless the DMCA comes into play.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

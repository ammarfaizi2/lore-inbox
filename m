Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTBCHwU>; Mon, 3 Feb 2003 02:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbTBCHwU>; Mon, 3 Feb 2003 02:52:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266091AbTBCHwT>;
	Mon, 3 Feb 2003 02:52:19 -0500
Message-ID: <3E3E21D3.1090402@pobox.com>
Date: Mon, 03 Feb 2003 03:01:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: RFC: a code slush for 2.5?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(ponderance on code freezes, releases, and whatnot)

My opinion of 2.5 could be summarized as, looking good, but still needs 
some fleshing out.

Linux 2.5 is a really exciting leap forward, in a lot a ways.  I'm still 
hoping someone will draft a "What's new in 2.6?" document, just so we 
have a nice _long_ list of all the improvements that have been made.

There are mumbles of things like "feature freeze" and "code freeze". 
Theoretically we already had a feature, but, ahem.  So, we need a 
yes-really-feature-freeze-this-time.

But at the same time, I _disagree_ with some kernel developers' 
assertion that we need a code freeze, if that is strictly the "nothing 
but bug fixes" definition.

I believe 2.5/2.6 would be better served by an addition period between 
feature freeze and code freeze, where implementation and "fleshing out" 
can take place.  Minor feature additions -- where required by existing 
major features -- should be ok.

Specific areas I think deserve attention before "nothing but bug fixes" 
includes a lot of driver implementation and testing for the driver 
model.  Pat's given us some cool stuff... that isn't used very much so 
far.  There are some key implementation decisions in that area that need 
to be made, before a lot of that can be used, too.  Power Management is 
another area.  That sorta fell by the wayside, IMO, but _is_ doable 
given the current infrastructure that 2.5 now has.  klibc is yet another 
thing that needs tackling.

Maybe I am coming from a "driver guy" bias, but it seems like calling a 
code freeze is premature.  I know everybody's chomping at the bit for 
2.6 to be released, already, gosh darn it.  But please consider this 
pause, as well.

So, if I had to make the proposal concrete, I would propose:
	"code slush" effective immediately
	code freeze, Easter holiday (April 19?)

Comments/curses?

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVARQdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVARQdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVARQdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:33:47 -0500
Received: from opersys.com ([64.40.108.71]:16654 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261344AbVARQda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:33:30 -0500
Message-ID: <41ED3C12.8030607@opersys.com>
Date: Tue, 18 Jan 2005 11:40:50 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Tom Zanussi <zanussi@us.ibm.com>
CC: Aaron Cohen <remleduff@gmail.com>, Roman Zippel <zippel@linux-m68k.org>,
       Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>	<41E899AC.3070705@opersys.com>	<Pine.LNX.4.61.0501160245180.30794@scrub.home>	<41EA0307.6020807@opersys.com>	<Pine.LNX.4.61.0501161648310.30794@scrub.home>	<41EADA11.70403@opersys.com>	<Pine.LNX.4.61.0501171403490.30794@scrub.home>	<41EC2DCA.50904@opersys.com>	<Pine.LNX.4.61.0501172323310.30794@scrub.home>	<41EC8AA2.1030000@opersys.com>	<727e501505011720303ba4f2cd@mail.gmail.com>	<41EC94BF.2080105@opersys.com> <16876.50139.587691.939056@tut.ibm.com>
In-Reply-To: <16876.50139.587691.939056@tut.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom Zanussi wrote:
> I have to disagree.  Awhile back, if you remember, I posted a patch to
> the LTT daemon that would monitor the trace stream in real time, and
> process it using an embedded Perl interpreter, no less:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109405724500237&w=2
> 
> It didn't seem to have any problems keeping up with the trace stream
> even though it was monitoring all LTT event types (and a couple of
> others - custom events injected using kprobes) and not doing any
> filtering in the kernel, through kernel compiles, normal X traffic,
> etc.  I don't know what volume of event traffic would cause this model
> to break down, but I think it shows that at least some level of
> non-trivial live processing is possible...

Good Point.

My bad. Thanks for bringing this up. Obviously this didn't get as
much attention as it should've had the last time it was posted,
especially as it allows very easy scripting of filtering in userspace.
That email you refer to is pretty loaded and I'm sure those who
are interested will dig through it. But in the interest of helping
everyone get a rapid understanding of what it does and how it does it,
can you break it down in to a short description, possibly with a
diagram? I'm sure many will find this very interesting.

Thanks,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

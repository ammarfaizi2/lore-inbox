Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVJSLAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVJSLAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVJSLAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:00:47 -0400
Received: from khc.piap.pl ([195.187.100.11]:29444 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964789AbVJSLAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:00:47 -0400
To: Anthony DeRobertis <anthony@derobert.net>
Cc: unlisted-recipients:"; (no To-header on input)
	Horms" <horms@verge.net.au>,
       security@kernel.org, team@security.debian.org, 334113@bugs.debian.org,
       linux-kernel@vger.kernel.org, Rudolf Polzer <debian-ne@durchnull.de>,
       Alastair McKinstry <mckinstry@debian.org>,
       secure-testing-team@lists.alioth.debian.org
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)Horms <horms@verge.net.au>
								     ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)Horms <horms@verge.net.au>
								     ^-missing end of address
Subject: Re: [Secure-testing-team] Re: kernel allows loadkeys to be used by
 any user, allowing for local root compromise
References: <E1EQofT-0001WP-00@master.debian.org>
	<20051018044146.GF23462@verge.net.au>
	<m37jcakhsm.fsf@defiant.localdomain> <4355C812.80103@derobert.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 19 Oct 2005 13:00:45 +0200
In-Reply-To: <4355C812.80103@derobert.net> (Anthony DeRobertis's message of
 "Wed, 19 Oct 2005 00:14:10 -0400")
Message-ID: <m3slux22le.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DeRobertis <anthony@derobert.net> writes:

> Well, you can configure a single vty to only allow logins from admins.
> Then you avoid the fake login problem, but not the loadkeys problem
> (since that affects all vtys)

Just a guess... Can you use loadkeys to change keys used for switching VTs?
I would investigate switchvt (or how is it named) too.
-- 
Krzysztof Halasa

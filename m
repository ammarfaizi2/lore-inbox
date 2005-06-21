Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVFUN10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVFUN10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVFUN1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:27:19 -0400
Received: from opersys.com ([64.40.108.71]:32261 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261474AbVFUNZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:25:09 -0400
Message-ID: <42B817AF.5040700@opersys.com>
Date: Tue, 21 Jun 2005 09:35:43 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Philippe Gerum <rpm@xenomai.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Kristian Benoit <kbenoit@opersys.com>
Subject: Re: [PATCH 1/2] I-pipe: Core implementation
References: <42B35B07.7080703@xenomai.org> <20050618170139.GA477@openzaurus.ucw.cz> <42B7272F.2040503@xenomai.org> <42B74781.8000109@opersys.com> <42B7BE86.6060502@xenomai.org>
In-Reply-To: <42B7BE86.6060502@xenomai.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Philippe Gerum wrote:
> Any objection to make the pipeline a static-only feature?

FWIW, we conducted our tests with the I-pipe loaded as a module.
Though we didn't publish that particular result as part of our
earlier posting, we found that the price for having it loaded,
but unused, versus not having it loaded at all made virtually
no difference on overall system overhead. Such results would
seem to indicate that having it as a loadable module has no
specific advantage. Note, though, that we didn't do the test on
all configs, just the "plain" one.

Of course the issue would be much easier to decide if you
could provide a brief explanation as to what the difference is, in
terms of execution path, between having it compilled as a module
and not loaded, versus having it built-in and unused.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

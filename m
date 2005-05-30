Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVE3SrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVE3SrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbVE3SrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:47:07 -0400
Received: from opersys.com ([64.40.108.71]:30221 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261630AbVE3SrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:47:00 -0400
Message-ID: <429B61F7.70608@opersys.com>
Date: Mon, 30 May 2005 14:56:55 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, kus Kusche Klaus <kus@keba.com>,
       James Bruce <bruce@andrew.cmu.edu>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Esben Nielsen wrote:
> Ofcourse, there is a lot of buts to that. You have to check that the
> driver doesn't take a call path which is nontermnistic in special cases
> and the path between your application and the driver is deterministic.
> A static code checker would be nice...

Which gets up back where we began: drivers that are non-deterministic
will continue being deterministic regardless of what solution is adopted,
if any, and will be in need of a re-write/major-modification, which
itself will have little or no added value for non-rters ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

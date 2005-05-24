Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVEXNZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVEXNZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVEXNXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:23:54 -0400
Received: from opersys.com ([64.40.108.71]:18697 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261470AbVEXNS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:18:58 -0400
Message-ID: <42932C32.8040500@opersys.com>
Date: Tue, 24 May 2005 09:29:22 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Christoph Hellwig <hch@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       sdietrich@mvista.com, Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505241123240.5002-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10505241123240.5002-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Esben Nielsen wrote:
> I find that a bad approach:
> 1) You don't have RT in userspace.
> 2) You can't use Linux drivers for standeard hardware when you want it to
> be part of your deterministic RT application.

Please have a look at RTAI/fusion. For the record, RTAI has been providing
hard-rt in standard Linux user-space for over 5 years now. With RTAI/Fusion
this gets even better as there isn't even a special API ...

Here are a few links if you're interested:
http://www.rtai.org/modules.php?name=Content&pa=showpage&pid=1
http://marc.theaimsgroup.com/?l=linux-kernel&m=111634653913840&w=2

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

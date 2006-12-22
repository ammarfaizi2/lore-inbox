Return-Path: <linux-kernel-owner+w=401wt.eu-S1946028AbWLVKaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946028AbWLVKaL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946029AbWLVKaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:30:10 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:53334 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946030AbWLVKaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:30:08 -0500
Date: Fri, 22 Dec 2006 11:30:05 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222103005.GC31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222003029.4394bd9a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Fri, Dec 22, 2006 at 12:30:29AM -0800, Andrew Morton wrote:
> To whom do I have to pay how much to get this darn patch tested?
I've already tested that (as I said somewhere in the bugzilla so
it probably got lost somehow :-) ): It doesn't solve the booting
problem, and I really don't have an idea what it does, nor does
it output any debug code. So I left it at: doesn't fix ;-).

Anyway: on to the ide_setup tracking....
(I've noticed that the notifier of this problem als has idebus=66
or something similar, so that explains in his case the
early call to ide_setup.)

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.

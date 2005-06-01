Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVFAPQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVFAPQC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFAPQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:16:02 -0400
Received: from opersys.com ([64.40.108.71]:37906 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261417AbVFAPPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:15:13 -0400
Message-ID: <429DD206.4060905@opersys.com>
Date: Wed, 01 Jun 2005 11:19:34 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Andrea Arcangeli <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
References: <20050531143051.GL5413@g5.random> <Pine.OSF.4.05.10505311652140.1707-100000@da410.phys.au.dk> <20050531161157.GQ5413@g5.random> <20050531183627.GA1880@us.ibm.com> <20050531204544.GU5413@g5.random> <429DA7AE.5000304@grupopie.com> <20050601135154.GF5413@g5.random> <20050601141919.GA9282@elte.hu> <20050601143202.GI5413@g5.random> <20050601144612.GJ5413@g5.random> <429DCD25.3010800@grupopie.com>
In-Reply-To: <429DCD25.3010800@grupopie.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paulo Marques wrote:
> This seems like the RTAI kind of nano-kernel approach and has nothing to 
> do with the way the RT-PREEMPT patch works, AFAICS.

Please read it again. Nanokernels/hypervisors are not an RTOS. They do
not schedule tasks or povide RT services. They only allow client OSes
to share hardware. IBM has been doing this for over 30 years. As for
RTAI, it is running side-by-side with another OS, it is not running
under Linux in a master-slave relationship.

I know things are polarized in this thread, but please avoid FUD.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

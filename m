Return-Path: <linux-kernel-owner+w=401wt.eu-S1752357AbWLVThm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbWLVThm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbWLVThm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:37:42 -0500
Received: from smtpa1.aruba.it ([62.149.128.210]:37661 "HELO smtpa2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752028AbWLVThl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:37:41 -0500
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
From: Stefano Takekawa <take@libero.it>
To: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>, Andrew Morton <akpm@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20061222184224.GK31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
	 <20061222184224.GK31882@telegraafnet.nl>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 20:39:39 +0100
Message-Id: <1166816379.4551.2.camel@proton.twominds.it>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
X-Spam-Rating: smtpa2.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am pretty sure the i386 tree has the same problem but I haven't checked yet.
> Anyway: the panic is just a way of noticing. The bug is that irq's are enabled
> before the irq controller is set up.

A very similar i386 linux installation works fine on my laptop, but that
i386 kernel never had problem.

-- 
Stefano Takekawa
take@libero.it

Frank:  And why do days get longer in the summer?
Ernest: Because heat makes things expand!



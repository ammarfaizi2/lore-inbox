Return-Path: <linux-kernel-owner+w=401wt.eu-S964980AbWLTKDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWLTKDo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWLTKDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:03:44 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:54472 "EHLO
	liaag2af.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964980AbWLTKDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:03:43 -0500
Date: Wed, 20 Dec 2006 04:59:19 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "ard@telegraafnet.nl" <ard@telegraafnet.nl>, take@libero.it,
       agalanin@mera.ru, linux-kernel@vger.kernel.org,
       bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Zhang Yanmin" <yanmin.zhang@intel.com>,
       "Andrew Morton" <akpm@osdl.org>
Message-ID: <200612200502_MC3-1-D5AF-1674@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 12/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > So an external interrupt occurred, the system tried to use interrupt
> > descriptor #39 decimal (irq 7), but the descriptor was invalid.
> 
> but the irq is disabled at that time.
> 
> can you use attached diff to verify if the irq is enable somehow?

But it seems interrupts are on--look at the flags:

        RSP: 0018:ffffffff803cdf68  EFLAGS: 00010246

-- 
MBTI: IXTP

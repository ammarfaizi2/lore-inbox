Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUHEUGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUHEUGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267936AbUHEUGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:06:10 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:9233 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S267935AbUHEUGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:06:05 -0400
Date: Thu, 5 Aug 2004 16:54:52 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error
Message-ID: <20040805195451.GA798@lorien.prodam>
Mail-Followup-To: Rick Lindsley <ricklind@us.ibm.com>,
	Adrian Bunk <bunk@fs.tum.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805182039.GN2746@fs.tum.de> <200408051915.i75JFN616956@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051915.i75JFN616956@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 05, 2004 at 12:15:23PM -0700, Rick Lindsley escreveu:

|     > This looks like it could happen if you compile without CONFIG_SMP ...
|     > which admittedly I have not tried since the sched-domain code was
|     > introduced.  Adrian, was this the situation in your case?
|     
|     Yes.
| 
| Ok.  Please try this patch (applied to rc3-mm1).

 Worked, I had the same problem.
 
 (yes, same SMP structures were in use).

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>

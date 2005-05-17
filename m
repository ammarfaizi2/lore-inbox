Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVEQXXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVEQXXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVEQXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:23:00 -0400
Received: from dvhart.com ([64.146.134.43]:21922 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261947AbVEQXWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:22:48 -0400
Date: Tue, 17 May 2005 16:22:44 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.12-rc4-mm2 boot failure
Message-ID: <919250000.1116372164@flay>
In-Reply-To: <743780000.1116279381@flay>
References: <735450000.1116277481@flay> <20050516142504.696b443b.akpm@osdl.org> <743780000.1116279381@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, May 16, 2005 14:36:21 -0700 "Martin J. Bligh" <mbligh@mbligh.org> wrote:

> 
> 
> --On Monday, May 16, 2005 14:25:04 -0700 Andrew Morton <akpm@osdl.org> wrote:
> 
>> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
>>> 
>>> PPC64 NUMA box. Maybe this is the same NUMA slab problem you were 
>>> hitting before ...
>> 
>> Probably.  Christoph, this patch has crossed the grief threshold - I'll
>> drop it.
> 
> OK, fair enough. Christoph, I am interested in seeing your patch work 
> ... is something that's needed. If you want, I can help you offline 
> with some testing on a variety of platforms.

OK, I backed out the slab patches from -mm2, and confirmed the problem 
went away.

M.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWIAI0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWIAI0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWIAI0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:26:17 -0400
Received: from gw.goop.org ([64.81.55.164]:5020 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751329AbWIAI0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:26:16 -0400
Message-ID: <44F7EEA2.3090600@goop.org>
Date: Fri, 01 Sep 2006 01:26:10 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 0/8] Implement per-processor data areas for i386.
References: <20060901064718.918494029@goop.org> <200609011016.45600.ak@suse.de>
In-Reply-To: <200609011016.45600.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I applied it now, with one change. I replaced the %Ps with %cs because
> that is apparently the more official way to do that in gcc. Please
> change that in your copy too.
>   

Do you mean the %P0, etc in the asms?

> There unfortunately were still quite a lot of rejects because -mm* 
> is too different from mainline, but I fixed them all.
>   
Thanks.  Were there more conflicts than entry.S?

    J

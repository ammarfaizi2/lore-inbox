Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWD1G55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWD1G55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWD1G54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:57:56 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:36816
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030279AbWD1G54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:57:56 -0400
Message-Id: <4451D94B.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 28 Apr 2006 08:58:51 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Zachary Amsden" <zach@vmware.com>
Cc: "Keir Fraser" <Keir.Fraser@cl.cam.ac.uk>,
       "Hugh Dickins" <hugh@veritas.com>, <linux-kernel@vger.kernel.org>,
       "Pratap Subrahmanyam" <pratap@vmware.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/2] I386 fix pte clear
References: <200604262203.k3QM3G9H009575@zach-dev.vmware.com> <4450AC7A.76E4.0078.0@novell.com> <44510E3D.10201@vmware.com>
In-Reply-To: <44510E3D.10201@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I'm also ack-ing the patch if that counts anything. Jan

>>> Zachary Amsden <zach@vmware.com> 27.04.06 20:32 >>>
Jan Beulich wrote:
> Actually, wouldn't it seem necessary to also to the same adjustment to pmd_clear() then?
>
> Jan
>   
Yes, it would.  I have also fixed the barrier to be smp_wmb as Nick 
pointed out.  Please apply.


Return-Path: <linux-kernel-owner+w=401wt.eu-S1759172AbWLIGK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759172AbWLIGK3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759182AbWLIGK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:10:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48788 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759172AbWLIGK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:10:26 -0500
Date: Fri, 8 Dec 2006 22:10:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, menage@google.com,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] cpuset - rework cpuset_zone_allowed api
Message-Id: <20061208221017.0c648b5e.akpm@osdl.org>
In-Reply-To: <20061208112152.12631.67436.sendpatchset@jackhammer.engr.sgi.com>
References: <20061208112152.12631.67436.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 03:21:52 -0800
Paul Jackson <pj@sgi.com> wrote:

> From: Paul Jackson <pj@sgi.com>
> 
> Elaborate the API for calling cpuset_zone_allowed(), so that users
> have to explicitly choose between the two variants:
> 
>   cpuset_zone_allowed_hardwall()
>   cpuset_zone_allowed_softwall()
> 
> Until now, whether or not you got the hardwall flavor depended solely
> on whether or not you or'd in the __GFP_HARDWALL gfp flag to the
> gfp_mask argument.

yeah, nice change that.


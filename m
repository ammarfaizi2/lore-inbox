Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUIHXnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUIHXnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269222AbUIHXnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:43:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:56237 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269218AbUIHXnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:43:17 -0400
Date: Wed, 08 Sep 2004 16:42:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Diego Calleja <diegocg@teleline.es>, Rik van Riel <riel@redhat.com>,
       raybry@sgi.com, marcelo.tosatti@cyclades.com, kernel@kolivas.org,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, piggin@cyberone.com.au
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <64810000.1094686934@flay>
In-Reply-To: <1094682510.12371.25.camel@localhost.localdomain>
References: <5860000.1094664673@flay> <Pine.LNX.4.44.0409081403500.23362-100000@chimarrao.boston.redhat.com> <20040908215008.10a56e2b.diegocg@teleline.es>  <36100000.1094677832@flay> <1094682510.12371.25.camel@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mer, 2004-09-08 at 22:10, Martin J. Bligh wrote:
>> I really don't see any point in pushing the self-tuning of the kernel out
>> into userspace. What are you hoping to achieve?
> 
> What if there is more than one right answer to "self-tune" policy. Also
> what if you want an application to tweak the tuning in ways that are
> different to general policy ?

It's still overridable from userspace, I'd think. But having a sensible
default in the kernel makes a crapload of sense to me. We have better
faster access to data from there - if there are really things that aren't
just parameters to the tuning algorithm it'd have to repeatedly poke 
values into hard overrides. Do-able, but not what we want by default,
I'd think.

M.


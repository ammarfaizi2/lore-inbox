Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVJXIh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVJXIh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 04:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVJXIh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 04:37:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:4767 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750775AbVJXIh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 04:37:28 -0400
Subject: Re: [PATCH 02/02] cpuset automatic numa mempolicy rebinding
From: Dave Hansen <haveblue@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Simon.Derr@bull.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <20051024072750.10390.32993.sendpatchset@jackhammer.engr.sgi.com>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
	 <20051024072750.10390.32993.sendpatchset@jackhammer.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 10:36:27 +0200
Message-Id: <1130142987.16002.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 00:27 -0700, Paul Jackson wrote:
> +               break;
> +       }
> +       default:
> +               BUG();
> +               break;
> +       }
> +}

Just think how that looks to a reviewer without the full context :)

Perhaps the MBOL_BIND case needs a little helper function.

-- Dave


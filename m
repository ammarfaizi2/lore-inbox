Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVAZOlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVAZOlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVAZOlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:41:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:17884 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262313AbVAZOlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:41:18 -0500
Date: Wed, 26 Jan 2005 06:37:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/5] consolidate i386 NUMA init code
Message-ID: <15640000.1106750236@flay>
In-Reply-To: <1106698985.6093.39.camel@localhost>
References: <1106698985.6093.39.camel@localhost>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following five patches reorganize and consolidate some of the i386
> NUMA/discontigmem code.  They grew out of some observations as we
> produced the memory hotplug patches.
> 
> Only the first one is really necessary, as it makes the implementation
> of one of the hotplug components much simpler and smaller.  2 and 3 came
> from just looking at the effects on the code after 1.
> 
> 4 and 5 aren't absolutely required for hotplug either, but do allow
> sharing a bunch of code between the normal boot-time init and hotplug
> cases.  
> 
> These are all on top of 2.6.11-rc2-mm1.

Looks reasonable. How much testing have they had, on what platforms?

M

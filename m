Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVA0CpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVA0CpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVAZXnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:43:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261804AbVAZSyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:54:21 -0500
Date: Wed, 26 Jan 2005 13:54:11 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-os <linux-os@analogic.com>
cc: Bryn Reeves <breeves@redhat.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <Pine.LNX.4.61.0501261325540.18301@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0501261353260.5677@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> 
 <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com> 
 <41F7D4B0.7070401@nortelnetworks.com> <1106762261.10384.30.camel@breeves.surrey.redhat.com>
 <Pine.LNX.4.61.0501261325540.18301@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.61.0501261353262.5677@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, linux-os wrote:

> Wrong! A returned value of 0 is perfectly correct for mmap()
> when mapping a fixed address. The attached code shows it working
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The code that is patched is only run in case of a non-MAP_FIXED
mmap() call...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

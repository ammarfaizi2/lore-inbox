Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTEXVAz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 17:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTEXVAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 17:00:54 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:54144
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261168AbTEXVAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 17:00:54 -0400
Date: Sat, 24 May 2003 17:03:57 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][2.5] provisional 32-way x445 patches
In-Reply-To: <Pine.LNX.4.50.0305241433270.2267-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0305241659530.16144-100000@montezuma.mastecende.com>
References: <200305232036.39297.jamesclv@us.ibm.com>
 <Pine.LNX.4.50.0305241433270.2267-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003, Zwane Mwaikambo wrote:

> Can't you just skip that one (-ENOSPC)? It would oops on 32way NUMAQ. Why 

crackpipe alert!! i didn't notice your s/int/u8/ change, regardless how 
are you handling irqs > 256? The code in 2.5.68 simply overwrites previous 
vector entries in your IDT when it runs out.

	Zwane
-- 
function.linuxpower.ca

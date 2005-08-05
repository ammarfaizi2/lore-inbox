Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVHEPDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVHEPDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVHEOxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:01 -0400
Received: from graphe.net ([209.204.138.32]:56233 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S263046AbVHEOwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:52:33 -0400
Date: Fri, 5 Aug 2005 07:52:27 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: NUMA policy interface
In-Reply-To: <20050805091630.GL8266@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508050750560.27054@graphe.net>
References: <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net>
 <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net>
 <20050804211445.GE8266@wotan.suse.de> <Pine.LNX.4.62.0508041416490.10150@graphe.net>
 <20050804214132.GF8266@wotan.suse.de> <Pine.LNX.4.62.0508041509330.10813@graphe.net>
 <20050804234025.GJ8266@wotan.suse.de> <Pine.LNX.4.62.0508041642130.15157@graphe.net>
 <20050805091630.GL8266@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Andi Kleen wrote:

> > Address space migration? That is something new in this discussion. So 
> > could you explain what you mean by that? I have looked at page migration 
> > in a variety of contexts and could not see much difference.
> 
> MCE page migration just puts a physical page to somewhere else.
> memory hotplug migration does the same for multiple pages from
> different processes.
> 
> Page migration like you're asking for migrates whole processes.

No I am asking for the migration of parts of a process. Hotplug migration 
and MCE page migration do the same.



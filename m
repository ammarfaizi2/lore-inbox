Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVHDXuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVHDXuf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVHDXud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:50:33 -0400
Received: from graphe.net ([209.204.138.32]:60821 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262759AbVHDXtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:49:35 -0400
Date: Thu, 4 Aug 2005 16:49:33 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: NUMA policy interface
In-Reply-To: <20050804234025.GJ8266@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508041642130.15157@graphe.net>
References: <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net>
 <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net>
 <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net>
 <20050804211445.GE8266@wotan.suse.de> <Pine.LNX.4.62.0508041416490.10150@graphe.net>
 <20050804214132.GF8266@wotan.suse.de> <Pine.LNX.4.62.0508041509330.10813@graphe.net>
 <20050804234025.GJ8266@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Andi Kleen wrote:

> None of them seem very attractive to me.  I would prefer to just
> not support external accesses keeping things lean and fast.

That is a surprising statement given what we just discussed. Things 
are not lean and fast but weirdly screwed up. The policy layer is 
significantly impacted by historical contingencies rather than designed in 
a clean way. It cannot even deliver the functionality it was designed to 
deliver (see BIND).

> Individual physical page migration is quite different from
> address space migration.

Address space migration? That is something new in this discussion. So 
could you explain what you mean by that? I have looked at page migration 
in a variety of contexts and could not see much difference.

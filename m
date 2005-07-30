Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVG3GAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVG3GAo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 02:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVG3GAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 02:00:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32700 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262945AbVG3GAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 02:00:41 -0400
Date: Fri, 29 Jul 2005 23:00:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
Message-Id: <20050729230026.1aa27e14.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0507291746000.8663@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
	<20050729152049.4b172d78.pj@sgi.com>
	<Pine.LNX.4.62.0507291746000.8663@graphe.net>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh - I should have mentioned this before - if you are displaying and
parsing node lists (nodemask_t) then there are wrappers for these
bitmap routines in linux/nodemask.h:

 * int nodemask_scnprintf(buf, len, mask) Format nodemask for printing
 * int nodemask_parse(ubuf, ulen, mask)   Parse ascii string as nodemask
 * int nodelist_scnprintf(buf, len, mask) Format nodemask as list for printing
 * int nodelist_parse(buf, map)           Parse ascii string as nodelist

See nodemask.h for other such useful routines.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265304AbUETWMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265304AbUETWMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUETWMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:12:05 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:37810 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265304AbUETWL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:11:58 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Date: Thu, 20 May 2004 18:10:48 -0400
User-Agent: KMail/1.6.2
Cc: davidm@hpl.hp.com, hch@infradead.org, linux-kernel@vger.kernel.org
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de> <16557.4709.694265.314748@napali.hpl.hp.com> <20040520145658.3a7bf7df.akpm@osdl.org>
In-Reply-To: <20040520145658.3a7bf7df.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405201810.48141.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 20, 2004 5:56 pm, Andrew Morton wrote:
> An alternative might be to remove all the ifdefs, build with
> -ffunction-sections and let the linker drop any unreferenced code...

That would probably be even more confusing than the #ifdefs.  At least with 
those you know that you need to check whether the current code will be 
called...

Jesse

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWAWMal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWAWMal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWAWMal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:30:41 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:47382 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1751320AbWAWMak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:30:40 -0500
Date: Sat, 21 Jan 2006 12:02:28 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       linux-mips@linux-mips.org
Subject: Re: Include assembly entry points in TAGS
Message-ID: <20060121120228.GC3456@linux-mips.org>
References: <17360.8073.622104.500429@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17360.8073.622104.500429@berry.gelato.unsw.EDU.AU>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:23:53AM +1100, Peter Chubb wrote:

> As it stands, etags doesn't find labels in the IA64 or i386 assembler source 
> code, because they're disguised inside a preprocessor macro. 
>  
> I propose the attached fix, which adds a regular expression to enable 
> labels disguised by ENTRY() and GLOBAL_ENTRY() macros. 
>  
> There's a similar problem for MIPS, which needs to match LEAF(entrypoint) 

There's also NESTED.  I don't use etags, so I won't try to cook a patch.

  Ralf

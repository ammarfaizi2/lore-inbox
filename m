Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVBOPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVBOPno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVBOPnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:43:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:53710 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261761AbVBOPnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:43:25 -0500
Date: Tue, 15 Feb 2005 07:40:56 -0800
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: holt@sgi.com, raybry@sgi.com, taka@valinux.co.jp, hugh@veritas.com,
       akpm@osdl.org, marcello@cyclades.com, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
 sys_page_migrate
Message-Id: <20050215074056.79781687.pj@sgi.com>
In-Reply-To: <1108407043.6154.49.camel@localhost>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	<1108242262.6154.39.camel@localhost>
	<20050214135221.GA20511@lnx-holt.americas.sgi.com>
	<1108407043.6154.49.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> Requiring that the process is stopped will somewhat limit the use of
> this API outside of the HPC space where so much control can be had over
> the processes. 

Good point.  Hopefully we can find a way to design this system
call so that it does not require suspension.  Some uses of it
may well choose to suspend, but that's a user space choice.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401

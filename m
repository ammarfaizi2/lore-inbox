Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTEHWdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTEHWdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:33:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55177
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262191AbTEHWdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:33:01 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305081546_MC3-1-3809-363D@compuserve.com>
References: <200305081546_MC3-1-3809-363D@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052430257.13551.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 22:44:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 20:43, Chuck Ebbert wrote:
> > you can write a stackable filesystem on linux, too and intercept any
> > I/O request.  You just have to do it through a sane interface, mount
> > and not by patching the syscall table - which you can do under
> > windows either.  (at least not as part of the public API).
> 
>   So when I register my filesystem, can I indicate that I want to be
> layered over top of the ext3 driver and get control anytime someone
> mounts an ext3 fileystem, so I can decide whether the volume being
> mounted is one that I want to intercept open/read/write requests for?

That would assume you had a right to dictate that the administrator
couldnt mount other file systems without your stacking.


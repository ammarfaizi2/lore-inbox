Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUBZHNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUBZHNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:13:21 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:50997 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262707AbUBZHNU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:13:20 -0500
Date: Thu, 26 Feb 2004 08:12:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Brian King <brking@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Question on MODULE_VERSION macro
Message-ID: <20040226071219.GA2253@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>, Brian King <brking@us.ibm.com>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040225213659.GA9985@mars.ravnborg.org> <20040226023341.42E862C270@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226023341.42E862C270@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 12:50:37PM +1100, Rusty Russell wrote:
> > The current implementation fails to locate include files in the local
> > directory when compiled using "make O=...".
> 
> There's no documentation I could find for "O=", BTW.  I'm not even
> sure what it does...
Check README in the kernel src.
Specify the output directory, allowing you to compile from RO media,
or just to have several kernel configs based on same src tree.

	Sam

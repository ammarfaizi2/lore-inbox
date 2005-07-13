Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVGMAmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVGMAmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVGMAmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:42:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54155 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262502AbVGMAlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:41:51 -0400
Date: Tue, 12 Jul 2005 17:41:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm2
Message-Id: <20050712174100.07fea532.akpm@osdl.org>
In-Reply-To: <200507122027_MC3-1-A44F-D6F8@compuserve.com>
References: <200507122027_MC3-1-A44F-D6F8@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
> 
> I downloaded 2.6.13-rc2-mm2-broken-out.tar.bz2 and verified the signature.
> 
> Then I untarred it and moved it to the patches/ dir.
> 
> Output of 'quilt push -a' ends with:
> 
>     Applying git-netdev-janitor-fixup.patch
>     patch: **** Only garbage was found in the patch input.
>     Patch git-netdev-janitor-fixup.patch does not apply (enforce with -f)

The patch was empty.  That happens sometimes.  I like to be able to apply
empty patches, but yes, perhaps that should require -f.

Either drop the patch of use -f.

>
> There were also a slew of patches that applied with offset errors before that.

I fix up the offset errors relatively infrequently, and they all come back
very soon.

> Is the broken-out tarfile supposed to be usable like this?

Yes.

Return-Path: <linux-kernel-owner+w=401wt.eu-S964806AbXASDuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbXASDuF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbXASDuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:50:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:54001 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964806AbXASDuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:50:04 -0500
Date: Fri, 19 Jan 2007 09:19:44 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Benjamin Romer <benjamin.romer@unisys.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Update disable_IO_APIC to use 8-bit destination field (X86_64)
Message-ID: <20070119034944.GA7136@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1169052407.3082.43.camel@ustr-romerbm-2.na.uis.unisys.com> <m1tzyp8o8v.fsf@ebiederm.dsl.xmission.com> <20070118034153.GA5406@in.ibm.com> <20070118043639.GA12459@in.ibm.com> <m1tzyo7qtc.fsf@ebiederm.dsl.xmission.com> <20070118080003.GC31860@in.ibm.com> <1169141034.6665.6.camel@ustr-romerbm-2.na.uis.unisys.com> <m14pqo6w3d.fsf@ebiederm.dsl.xmission.com> <1169147619.6665.11.camel@ustr-romerbm-2.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169147619.6665.11.camel@ustr-romerbm-2.na.uis.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 02:13:39PM -0500, Benjamin Romer wrote:
[..]
> > >
> > > OK, here's the updated patch that uses the new definition and fixes up
> > > the other places that use it. I built and tested this on the ES7000/ONE
> > > and it works well. :)
> >
> > Cool.
> >
> > I hate to pick nits by why the double underscore on dest?
> >
> 
> It was defined that way in the updated structure definition you sent in
> a previous mail, so I figured you wanted it that way. Here's another
> revision with the double underscores removed. :)
> 
> -- Ben
> 

This patch looks good to me. You might want to provide some description
too for changelog.

Thanks
Vivek

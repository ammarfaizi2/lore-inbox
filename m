Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261728AbUJYJdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUJYJdg (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 25 Oct 2004 05:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUJYJdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:33:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:18646 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261728AbUJYJde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:33:34 -0400
Subject: Re: 2.6.9-mm1 : compile error & question
From: Vivek Goyal <vgoyal@in.ibm.com>
To: remi.colinet@free.fr
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
        suparna bhattacharya <suparna@in.ibm.com>,
        vara prasad <varap@us.ibm.com>,
        Hariprasad Nellitheertha <hari@in.ibm.com>
In-Reply-To: <1098695733.417cc43516b8c@imp2-q.free.fr>
References: <417C2619.7060808@free.fr>
	 <1098688622.2563.16.camel@2fwv946.in.ibm.com>
	 <1098695733.417cc43516b8c@imp2-q.free.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1098697883.2563.27.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Oct 2004 15:21:23 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Remi,

On Mon, 2004-10-25 at 14:45, remi.colinet@free.fr wrote:

> Does it mean that the .text LMA start address is going to be definitively 0010
> 0000, even for those who disable kexec in their .config file?

Yes. 

> >
> > This looks like a problem with the older binutils package. I had faced
> > similar problem on one of the machines but it was resolved as soon as I
> > switched to a newer binutils package.
> 
> My distro is effectively becoming old (FC1). Going to upgrade it.

We are trying to find out why older versions of binutils create this
problem. Also looking into if compatibility can be ascertained between
this new patch and older version of binutils.

Thanks 
Vivek

> 
> Thanks
> Remi
> 
> 
> 


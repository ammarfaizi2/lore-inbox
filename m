Return-Path: <linux-kernel-owner+w=401wt.eu-S1750849AbWLWCev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWLWCev (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 21:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWLWCev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 21:34:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:54748 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbWLWCeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 21:34:50 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.20-rc1
Date: Fri, 22 Dec 2006 21:34:13 -0500
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org
References: <200612200434.56516.lenb@kernel.org> <Pine.LNX.4.64.0612202357110.3576@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612202357110.3576@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612222134.14054.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 December 2006 02:58, Linus Torvalds wrote:
> 
> On Wed, 20 Dec 2006, Len Brown wrote:
> > 
> > please pull from: 
> 
> Is this really all obvious bug-fixes? There seems to be a lot of 
> development there that simply isn't appropriate after an -rc1 any more.
> 
> I want 2.6.20 to be stable, and one of the things I'm doing is to be 
> strict about the merge window.

Yes, I recommend pulling this tree now.
While there is a fair amount of text changed, the functional changes
here are actually quite small, and have been in -mm for a long time --
some of them already shipping in distros before being upstream.

Yes, there is a fair amount of fluffy cleanup here -- seems there is
never a good time in the release cycle to do them, but as andrew says,
we're in this for the long term, so we do have to do them some time.
I don't see any big risks in them so it seems appropriate to push after rc1.

Note that there is a much larger body of ACPI changes in flight
that I have excluded from this pull request and are waiting for 2.6.21.

thanks,
-Len

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbUKXUd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbUKXUd4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbUKXUcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:32:52 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17860 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262845AbUKXU1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:27:50 -0500
Subject: Re: Suspend 2 merge: 18/51: Debug page_alloc support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101312173.8940.47.camel@localhost>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295326.5805.259.camel@desktop.cunninghams>
	 <1101312173.8940.47.camel@localhost>
Content-Type: text/plain
Message-Id: <1101327214.3425.6.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 07:17:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 03:02, Dave Hansen wrote:
> On Wed, 2004-11-24 at 04:58, Nigel Cunningham wrote:
> > +#ifdef CONFIG_HIGHMEM
> > +	if (page >= highmem_start_page) 
> > +		return 0;
> > +#endif
> 
> There's a patch pending in -mm to kill highmem_start_page.  Please use
> PageHighMem().

That's not out-of-line, is it? (We use it while resuming too, IIRC).
I'll take a look.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6


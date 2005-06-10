Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVFJQXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVFJQXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVFJQXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:23:01 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:8224 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262601AbVFJQWn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:22:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SnutmlpcllIWRCz8OcxyOpcgZeRkflI8BpgB1IfmDLvWhExh2MZFCt+t9KKhk3/qNgFb3lu6t2YObTz1usrOgHgVeMOWe4PHILGM6uf+gxSUSa8bLBncuZTyA7QQ2q4RW6PjmQh4NalXqyZCkMU2KftZDQG9f7RLZ/l5R/DlRCw=
Message-ID: <a728f9f9050610092254dd8e87@mail.gmail.com>
Date: Fri, 10 Jun 2005 12:22:41 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: [Jfs-discussion] fsck.jfs segfaults on x86_64
Cc: jfs-discussion@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ag@m-cam.com
In-Reply-To: <1118420190.21406.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a728f9f90506100700107976f0@mail.gmail.com>
	 <1118412882.7944.6.camel@localhost>
	 <a728f9f905061007216c38cf4c@mail.gmail.com>
	 <a728f9f905061009097081c0a6@mail.gmail.com>
	 <1118420190.21406.4.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/05, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> On Fri, 2005-06-10 at 12:09 -0400, Alex Deucher wrote:
> 
> > 1.1.8 segfaulted as well.
> 
> Hmm.  This bothers me.

let me know if there's anythign else you need me to test.  I suppose
it must have been something odd in the journal because it hadn't ever
segfaulted on any previous runs before that last SAN failure.

> 
> > running fsck.jfs --omit_journal_replay did the trick!  thanks,
> 
> Well, at least it got you going again.  :^)

Thanks for your help!

Alex

> 
> Thanks,
> Shaggy
> --
> David Kleikamp
> IBM Linux Technology Center
> 
>

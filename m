Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVHLQSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVHLQSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVHLQSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:18:14 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:45697 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751217AbVHLQSN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:18:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZZzeb/lreGes0iqhsyS9SrM2i5SuRMSioexLIBXzqiLj1zQgJqtfPDqYf3L1fw+MsfDHGUgY05oLPYtXy7HIpSBd3twEeC8wKRUSy1sMK87bKh++8FLV7TEfWk57flPq0+5Hy6pO+w/VqtDu8S1KO36Tv1wX9DtvJRgFmjOx7YE=
Message-ID: <86802c4405081209187e51878@mail.gmail.com>
Date: Fri, 12 Aug 2005 09:18:07 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.13-rc2 with dual way dual core ck804 MB
Cc: Mike Waychison <mikew@google.com>, Peter Buckingham <peter@pantasys.com>,
       linux-kernel@vger.kernel.org, "discuss@x86-64.org" <discuss@x86-64.org>
In-Reply-To: <20050812130725.GL8974@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42FA8A4B.4090408@google.com>
	 <86802c4405081016421db9baa5@mail.gmail.com>
	 <20050811000430.GD8974@wotan.suse.de>
	 <86802c4405081017174c22dcd5@mail.gmail.com>
	 <86802c440508101723d4aadef@mail.gmail.com>
	 <20050811002841.GE8974@wotan.suse.de>
	 <86802c440508101743783588df@mail.gmail.com>
	 <20050811005100.GF8974@wotan.suse.de>
	 <86802c4405081123597239dff7@mail.gmail.com>
	 <20050812130725.GL8974@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

good, I will produce one patch next week.

YH

On 8/12/05, Andi Kleen <ak@suse.de> wrote:
> On Thu, Aug 11, 2005 at 11:59:21PM -0700, yhlu wrote:
> > andi,
> >
> > is it possible for
> > after the AP1 call_in is done and before AP1 get in tsc_sync_wait
> > The AP2 call_in done.  and then AP1 get in tsc_sync_wait and before it
> > done, AP2 get in tsc_sync_wait too.
> >
> > sync_master can not figure out from AP1 or AP2 because only have
> > go[MASTER] and go{SLAVE].
> 
> Ok, you're right. It's better to move it to before callin map.
> 
> -Andi
>

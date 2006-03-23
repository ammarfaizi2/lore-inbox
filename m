Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWCWQ4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWCWQ4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWCWQ4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:56:45 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:16116 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932174AbWCWQ4o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:56:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AQlUsqmviGNv80lNNg4A1l51NFyUlTLqY29Kw7HVCPjRITC8xH5bPUZo4r+t8qGBy9OgVXSpN9PLDaORBT3KSr3rlltVt5StVclqTc2rQ0HEo+oWHmT7FFl3bco6X17b4v4OKNj0Y2kiERLi4POyGlE5iShz24Uact5lHzdHHAA=
Message-ID: <728201270603230855l11faeb6ah33ee88568843068f@mail.gmail.com>
Date: Thu, 23 Mar 2006 10:55:30 -0600
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: RSS Limit implementation issue
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <1139526447.6692.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
	 <1139526447.6692.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2006-02-09 at 15:10 -0600, Ram Gupta wrote:
> > I am working to implement enforcing RSS limits of a process. I am
> > planning to make a check for rss limit when setting up pte. If the
> > limit is crossed I see couple of  different ways of handling .
> >
> > 1. Kill the process . In this case there is no swapping problem.
>
> Not good as the process isn't responsible for the RSS size so it would
> be rather random.
>

I doubt I am missing some point here. I dont understand why the
process isn't responsible for RSS size. This limit is process specific
& the count of rss increases when the process maps some page in its
page table.

Thanks
Ram Gupta

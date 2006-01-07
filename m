Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbWAGTmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbWAGTmv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWAGTmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:42:51 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:60544 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030554AbWAGTmu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:42:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FWg8ufSa92wDs0r1R/JGnmEuFApBz1rRnM8jDF7OMifAUsolPkefyo1dmWSj1padSfoXw5JdAk7vxRUD/1UpUDkxHim3p3eUE9zLGvfBqTYOJgn3qLIaTwy+6WVBoFMl5belLxSDe9Ao/6JNHvmgRgwBIv8E98sfdE5+JmcW7xk=
Message-ID: <b6c5339f0601071142i78db77e1v7c8056197bb43dab@mail.gmail.com>
Date: Sat, 7 Jan 2006 14:42:50 -0500
From: Bob Copeland <email@bobcopeland.com>
To: "Kurtis D. Rader" <kdrader@us.ibm.com>
Subject: Re: Platform device matching, & weird strncmp usage
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060107192458.GA12409@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1136527179.4840.120.camel@localhost.localdomain>
	 <20060107192458.GA12409@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/06, Kurtis D. Rader <kdrader@us.ibm.com> wrote:
> On Fri, 2006-01-06 16:59:39, Benjamin Herrenschmidt wrote:
> > As far as I know, strncmp() is _NOT_ supposed to return 0 if one string
> > is shorter than the other and they match until that point

> I can't speak to the correctness of that code but your understanding of
> strncmp() is incorrect. From "GNU C Library Application Fundamentals":

I believe the original poster was asserting that
'strncmp("abc","abcd",100) should never return zero,' and not
'strncmp("abc","abcd",3) should never return zero.'  Though I also
found the statement confusing at first.

-Bob

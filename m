Return-Path: <linux-kernel-owner+w=401wt.eu-S965138AbXAJWCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbXAJWCM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbXAJWCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:02:12 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:36727 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965138AbXAJWCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:02:11 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jHAhXlRjqgqegTWf8dTyfBbvSYDB2BfzL2faylvexomylFQ3QGnJlC7+aQKjmgD3nQ+lD2WMCIo931oOqazsdMNKH94Uul1UQsrB+yJcF5MxT8VlPjc3/2OltyCXl4fBW/SKHiDm5cEibYbzoIgDaaSfn+X0AgSfuCPAPi1GHP0=
Message-ID: <7c737f300701101402q21ee4a8dr1ef32771d8cd78a2@mail.gmail.com>
Date: Wed, 10 Jan 2007 14:02:09 -0800
From: "Alexy Khrabrov" <deliverable@gmail.com>
To: "Bill Davidsen" <davidsen@tmr.com>
Subject: Re: installing only the newly (re)built modules
Cc: "Linux Kernel mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <45A5609C.1000308@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7c737f300701082029i1ce9f7d8oc67cb3339c9c2856@mail.gmail.com>
	 <45A5609C.1000308@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, fast -- it depends!  :)  My Crusoe tablet, Compaq TC1000, can
use any break it gets...  And generally, the beauty of a make system
is not to do any extra moves.  Since it already knows what to build,
why not let it install just that?

Cheers,
Alexy

On 1/10/07, Bill Davidsen <davidsen@tmr.com> wrote:
> Alexy Khrabrov wrote:
> > The 2.6 build system compiles only those modules whose config
> > changed.  However, the install still installs all modules.
> >
> > Is there a way to entice make modules_install to install only those
> > new modules we've actually just changed/built?
>
> Out of curiosity, why? I've noticed this, but the copy runs so fast I
> never really thought about it as an issue.
>
> --
> bill davidsen <davidsen@tmr.com>
>    CTO TMR Associates, Inc
>    Doing interesting things with small computers since 1979
>

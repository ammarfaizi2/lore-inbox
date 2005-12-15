Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVLOSff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVLOSff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVLOSff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:35:35 -0500
Received: from [212.76.81.44] ([212.76.81.44]:64780 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750881AbVLOSfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:35:34 -0500
From: Al Boldi <a1426z@gawab.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Thu, 15 Dec 2005 21:29:01 +0300
User-Agent: KMail/1.5
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
References: <200512150013.29549.a1426z@gawab.com> <200512151131.39216.a1426z@gawab.com> <43A1501F.5070803@aitel.hist.no>
In-Reply-To: <43A1501F.5070803@aitel.hist.no>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200512152129.01861.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Disadvantages of a stable API:
> * It encourages binary-only drivers, while we prefer source drivers.
>    Changing the API often and without warning is one way of
>    hampering binary-only driver development without harming
>    open-source drivers.

You are really shooting yourself in the foot here.

> Do a stable API save us work?  No, because whoever changes the API
> also fixes all in-kernel users of said API. 

That's very inefficient.

> how is non-OpenSource different? What can we do better? How can we
> learn from them?

Pretty much nothing, except for taking advantage of their precooked 
interconnectivity api's, in which they excel in abstracting them pretty 
well.

> > If you are working alone a stable API would be overkill.  But GNU/Linux
> > is a collective effort, where stability is paramount to aid scalability.
> >
> > I hope the concepts here are clear.
>
> No, it's not clear what you mean by scalability.  What is it exactly that
> you think would be more scalable?   As has been mentioned already, there
> is no better example today of scalable development than the Linux kernel.
> So, I don't think you've laid out at all what it is you're talking about.
>
> I think I don't get how you come from "stable API" to "aid scalability"
> in the light that the current non-API doesn't seem to prevent
> scalability to the size linux development is today.
>
> The linux kernel development model scales very well.  Linux itself scales
> from the smallest embedded processors to the largest parallel computing
> farms today; all without a stable internal API.  So you've failed to make
> a case that there is a problem for which a stable API is the solution.
>
> Another option is that your assumption about "stability as a requirement
> for scalability" is wrong at least in case of the kernel.  The kernel
> development scales very well so far.  I can't see any delays caused by
> developers trying to keep up with a change in binary APIs.  Well,
> except a handful of closed source vendors, but that is more or less
> intentional.  If they get tired, they can hand in their source.
>
> I think most believe what I do: that our development model is scalable
> (scalability seems to be the least of its worries), and that unstable
> APIs are not a bad thing.

Don't mistake scalability for manageability/mantainability or flexibility.  
Scalability is more, much more.  It's about extendability and reusability 
built on a solid foundation that may be stacked.  Layers upon layers, the 
sky is the limit.  Stability is the key to unlock this scalability.

> > No troll! Just being IMHO. I hope that's OK?
>
> That's fine, but Linux and the development process is a personal
> achievement and creation of many here, so you have to try to be
> respectful :)

Sorry! Can you point out which part was offending?

Thanks!

--
Al


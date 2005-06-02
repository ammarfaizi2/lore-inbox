Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVFBXBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVFBXBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVFBXAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:00:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:12476 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261332AbVFBW5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:57:05 -0400
Message-ID: <429F8EB8.2010406@pobox.com>
Date: Thu, 02 Jun 2005 18:56:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DocBook build failures, and graphical figures
References: <429CAD7B.5070301@pobox.com> <20050531212141.GC14161@admingilde.org>
In-Reply-To: <20050531212141.GC14161@admingilde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> hoi :)
> 
> On Tue, May 31, 2005 at 02:31:23PM -0400, Jeff Garzik wrote:
> 
>>In each failing case, I can use "db2ps" or "db2pdf" to successfully 
>>convert the XML file, whereas xmlto fails.
> 
> 
> yes, passivetex (which is used by xmlto to process XML-FO) is not as
> stable as I thought.
> It breaks at strange times but I did not yet had the energy to really
> look into it.
> So we probably have to support db2pdf/ps again.

Cool, just wanted to make sure it got noticed and fixed.


>>* Can you make it easy to change the paper size to something custom, 
>>like 6x9in ?
> 
> 
> you should be able to put the following lines into stylesheet.xsl:
> <param name="paper.width">6in</param>
> <param name="paper.height">11in</param>
> 
> would it be easy enough if I provided some commented out entries?

don't bother.  I was just curious for my own knowledge.


> (well the above only works for xmlto, I don't know how to set
> the paper size for db2*)

Yeah, as I have discovered :/


>>* Is there an example somewhere describing how to insert graphics 
>>(figures and charts) ?
> 
> 
> you can insert graphics with
> <mediaobject><imageobject>
> <imagedata fileref="blah.png" format="PNG"/>
> </imageobject></mediaobject>
> (See http://www.faqs.org/docs/docbook/html/mediaobject.html)
> 
> The above generates an <img src="blah.png"> in HTML mode.
> Is that what you want?

Yep!

I was curious how to include images (and figures) in the kernel docbook 
docs.  The above example and URL were more than enough to get me going.

Thanks,

	Jeff



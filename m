Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbUBYTBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBYS7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:59:43 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:64776 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261732AbUBYS7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:59:25 -0500
Message-ID: <403CF2E7.4020303@techsource.com>
Date: Wed, 25 Feb 2004 14:09:27 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Sam Ravnborg <sam@ravnborg.org>, Rik van Riel <riel@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       "Woodruff, Robert J" <woody@co.intel.com>, linux-kernel@vger.kernel.org,
       "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       marcelo.tosatti@cyclades.com
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <Pine.LNX.4.44.0402242238020.15091-100000@chimarrao.boston.redhat.com> <403CCC77.6030405@techsource.com> <20040225185553.GA2474@mars.ravnborg.org> <Pine.LNX.4.58.0402251003440.2461@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402251003440.2461@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:
> 
> On Wed, 25 Feb 2004, Sam Ravnborg wrote:
> 
>>If we take the vendor persåective here. Then why should they make their
>>driver open source, when the middle layer is not part of the 
>>main stream kernel?
> 
> 
> And why should we take the vendor perspective?
> 
> We don't add drivers for stuff that doesn't exist, and is not even likely 
> to be used much. That way, when problems occur (and they _will_ occur), 
> the burden of the crap will be firmly on the shoulders of the people who 
> should care.

I was not suggesting that we add drivers or even the middle layer to the 
mainline kernel until there is some use for it.  Rather, it wouldn't be 
a bad idea for someone to DEVELOP it as a patch which could be mainlined 
the moment there became a demand for it.  This also leaves the work in 
the hands of those who should care, because anyone using the middle 
layer has the 'disadvantage' of using a non-standard patch which they 
have to take responsibility for using.


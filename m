Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWCGDC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWCGDC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWCGDC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:02:28 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:18348 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932629AbWCGDC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:02:28 -0500
Message-ID: <440CF7B6.7050605@vilain.net>
Date: Tue, 07 Mar 2006 16:02:14 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
References: <20060306235248.20842700@localhost.localdomain>	 <20060306235249.880CB28A@localhost.localdomain>	 <20060307010139.GF27645@sorel.sous-sol.org> <1141697051.9274.58.camel@localhost.localdomain>
In-Reply-To: <1141697051.9274.58.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>>Interesting idea.  One piece that's missing is strategy for controlling
>>creation the new context (assuming the data_access() will always evaluate
>>into a context sensitive piece of data).  Otherwise a user can get out
>>of the limits imposed by sysadmin (since they may have placed themselves
>>in a context which differs from admin).
>>    
>>
>Yup, that is missing for now.  We couldn't agree on quite which
>implementation we want for basic containers/vservers/vpses.  So, for
>now, making it useful is left as an exercise to the reader. :)
>
>BTW, the current code _is_ potentially context sensitive because
>"current" provides much of the context that we will ever need.
>  
>

I have an RFC quality submission ready, extracted from Herbert's work. 
I'll prepare and forward it to the ML now for reference.

Sam.

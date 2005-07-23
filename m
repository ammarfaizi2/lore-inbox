Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVGWWhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVGWWhC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVGWWhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:37:02 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:54001 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261913AbVGWWhA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:37:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jyfHwQ3sOjrSOykyi10R8R7WLQce1UmKx8CjTe7kePD++/NHcu1wftJ3f6TGjP6BnRci6xSGH+P3yCkr4jdd3GE3R/mmgfz3MHPq24xEYlo3WzOtBaeuwNxSQFluDQVj0dlmjqB1o1VkK7V2XWYCZsLWuk0Ws3ZTUjqghsRAhjE=
Message-ID: <21d7e9970507231537713eab0f@mail.gmail.com>
Date: Sun, 24 Jul 2005 08:37:00 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <1122148537.27629.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0507221942540.5475@skynet>
	 <E1Dw6lc-0007IU-00@chiark.greenend.org.uk>
	 <1122148537.27629.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> For Intel at least the recommendation is to use the BIOS "save
> mode"/"restore mode" interface.

I'm going to see about implementing that on my PC when I get back to
home, it doesn't seem like too bad an idea either...

We are also going to provide some hooks out to userspace as well.. but
I'd be interested in trying as many in-kernel solutions before going
down that road...

Dave.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290315AbSAXV1b>; Thu, 24 Jan 2002 16:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290320AbSAXV1V>; Thu, 24 Jan 2002 16:27:21 -0500
Received: from svr3.applink.net ([206.50.88.3]:27655 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290307AbSAXV1P>;
	Thu, 24 Jan 2002 16:27:15 -0500
Message-Id: <200201242123.g0OLNAL06617@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: RFC: booleans and the kernel
Date: Fri, 25 Jan 2002 15:24:39 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 14:39, Oliver Xymoron wrote:
>
> The compiler _will_ turn if(a==0) into a test of a with itself rather than
> a comparison against a constant. Since PDP days, no doubt.

I thought that the whole point of booleans was to stop silly errors
like 

if ( x = 1 )
{
	printf ("\nX is true\n");
}
else
{
	# we never get here...
}

-- 
timothy.covell@ashavan.org.

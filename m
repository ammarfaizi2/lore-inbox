Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275478AbTHNUHg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275482AbTHNUHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:07:36 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:7923 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S275478AbTHNUHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:07:34 -0400
Message-ID: <3F3BEBFB.7010003@nortelnetworks.com>
Date: Thu, 14 Aug 2003 16:07:23 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
References: <20030809173329.GU31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:

> I don't see where you are getting this from.  Define
>   F(x) = first80bits(SHA(x))
>   G(x) = first80bits(SHA(x)) xor last80bits(SHA(x)).
> What makes you think that F is a better (or worse) hash function than G?
> 
> I think there is little basis for discriminating between them.
> If SHA is cryptographically secure, both F and G are fine.

In this case we can save the bother of doing the xor, no?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com


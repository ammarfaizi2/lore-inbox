Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbRFUMn7>; Thu, 21 Jun 2001 08:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbRFUMnt>; Thu, 21 Jun 2001 08:43:49 -0400
Received: from web13605.mail.yahoo.com ([216.136.175.116]:11013 "HELO
	web13605.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264939AbRFUMni>; Thu, 21 Jun 2001 08:43:38 -0400
Message-ID: <20010621124337.44506.qmail@web13605.mail.yahoo.com>
Date: Thu, 21 Jun 2001 05:43:37 -0700 (PDT)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Re: Is it useful to support user level drivers
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15D2GI-00019a-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The problem is that the IRQ has to be cleared in
> kernel space, because otherwise
> you may deadlock. 
> 

I agree, the idea is to clear the IRQ in kernel space
and then deliver to user level programs interested
using a signal (Real time SIGINT or something similar)
If somebody is interested I could in sometime come
up with what I have in mind and send it to this list,
accept comments and criticism.

Balbir


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVFRF3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVFRF3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 01:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVFRF3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 01:29:13 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:53872 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262064AbVFRF3K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 01:29:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SxuLiuOX5qGhJajJWUG76CRnWHi8+IODeaH1QD7xNxIu4MWK2azWtL5mXhuY/7XWIcdvyYMn4ahTsiP7yyal6bSXPyjArRD9JE7eL8eYUBaG/W1iGqlHmOfLAu1h3nTfsKIR8t59+mjZf/ZaRlyfezF0512Jnqj+DMjyhUvFMas=
Message-ID: <4ad99e05050617222966671e4f@mail.gmail.com>
Date: Sat, 18 Jun 2005 07:29:09 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Lincoln Dale <ltd@cisco.com>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Cc: Valdis.Kletnieks@vt.edu, abonilla@linuxwireless.org,
       Christian Kujau <evil@g-house.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42B353B7.4070503@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com>
	 <200506171352.j5HDqpE8006543@turing-police.cc.vt.edu>
	 <42B353B7.4070503@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/05, Lincoln Dale <ltd@cisco.com> wrote:
> there _was_ a bug in the Cisco PIX whereby it cleared TCP window-scaling
> bits.
> this can be tracked through cisco bug-id CSCdy29514.
> 
> this was fixed back in August 2002 with the fix incorporated into PIX
> software releases 6.1.5 and 6.2.3 and later.
> any 'recent' (i.e. last 2.5 years) releases don't have this problem.
> (or, at least, we don't think so..).

I have identified two firewalls with this problem and both of then are
running PIX software version 6.3.4 - I have not yet managed to
persuade there respective admins to update to 7.0.1 (or 6.3.4.115) -
so until then I am just turning window-scaling off.



Regards.

Lars Roland

Return-Path: <linux-kernel-owner+w=401wt.eu-S932222AbXAHIrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbXAHIrK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbXAHIrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:47:10 -0500
Received: from web55605.mail.re4.yahoo.com ([206.190.58.229]:28172 "HELO
	web55605.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932229AbXAHIrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:47:09 -0500
Message-ID: <20070108084707.48375.qmail@web55605.mail.re4.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=UOlCaj9rmyy6toQtcKrgk8rPZ/bT9oYNJ93NDMclHxoODxWI9mjcEFjolSW+K/kuWtRvJp9X1PHhZAo3EjDuF2oGw+blC9jYSw6Jofpe72tCZQO+SsJLwA7Sh3dNd+NolKzbMfx3FqAKlXHjArsDRXfpfDYUdqQt5D2NNYplYLA=;
X-YMail-OSG: sovVcf8VM1kiku0hx9dcrqEUqph3bq6gmEwqVGBnxDA2K.CHnkd4ZAh_HEZtCNULhqYHjIoyeiHncMpG5BHLTqhMISrHtqiFg8K7sjVRhMK_YWzUR4oDBkBm5ym.U4hGSgaykHrbnuefeSk9AUrkLJIN
Date: Mon, 8 Jan 2007 00:47:07 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1168244100.9034.2.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> On Sun, 2007-01-07 at 23:29 -0800, Amit Choudhary wrote:
> > I do not want to write this but I think that you are arguing just for the heck of it. Please
> be
> > sane.
> 
> No, I'm merely trying to demonstrate, on a logical basis, why the
> proposed patch does not (in my opinion) belong within the kernel. The
> fact that I'm not alone in voicing such disagreement should mean
> something.
> 

I agree that since couple of people are voicing disagreement the definitely it means something and
probably it means that you are right.

Let's try to apply the same logic to my explanation:

KFREE() macro has __actually__ been used at atleast 1000 places in the kernel by atleast 50
different people. Doesn't that lend enough credibility to what I am saying.

People did something like this 1000 times: kfree(x), x = NULL. I simply proposed the KFREE() macro
that does the same thing. Resistance to something that is already being done in the kernel. I
really do not care whether it goes in the kernel or not. There are lots of other places where I
can contribute. But I do not understand the resistance.

It is already being done in the kernel.

-Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

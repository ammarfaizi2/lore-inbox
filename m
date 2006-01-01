Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWAARJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWAARJQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 12:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWAARJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 12:09:16 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:61387 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751100AbWAARJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 12:09:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e7Ryis/iSto6tTQZDUvZeKqtx2UrjCKvoqd3WVioQA5kEtRpCM/KocDurijl7ySKOe0xz1UMYVdhP3I3dTm2qr9S70HBGjUKQKHQI7MzJmh3WsyDmb9AWNjwMwmic+6UldqygFUQhmGaqx7n7VU0nCtL95SQMQoZtKAfJ/Sa03o=
Message-ID: <84144f020601010909n3b59f006n23c214dfd2d81062@mail.gmail.com>
Date: Sun, 1 Jan 2006 19:09:13 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Integer types
Cc: Jeff Sipek <jeffpc@optonline.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1136044043.3516.155.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051231084719.GA6702@optonline.net>
	 <84144f020512310155r4e99006cn21c5d622b544baa1@mail.gmail.com>
	 <1136044043.3516.155.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2005-12-31 at 11:55 +0200, Pekka Enberg wrote:
> > > * u8, u16, ...
> > > * uint8_t, uint16_t, ...
> > > * u_int8_t, t_int16_t, ...
> >
> > From the above list, the first ones. See
> > http://article.gmane.org/gmane.linux.kernel/259313. Please note that
> > there's also __le32 and __be32 for variables that have fixed byte
> > ordering.

On 12/31/05, David Woodhouse <dwmw2@infradead.org> wrote:
> As ever, however, be aware that our esteemed leader is fickle.
> Especially when he's wrong, as he was on that occasion.

Maybe so but some maintainers do require them. So as for the original
question, I would still recommend the u8 ones as they are most likely
merged as is.

                                   Pekka

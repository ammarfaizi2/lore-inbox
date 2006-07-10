Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161136AbWGJNOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbWGJNOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGJNOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:14:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1873 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161136AbWGJNOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:14:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rwVbkbj2F2RczJ6AlApfVNe3Qh7eX0tr4iQy+0xuTadRKobF2637nsM5WZ58HSC6UW3pnAedKJzuJlX92HjDFxbm+2cwZnG7hdeNsDD8qhMFwqRC0u+CFe2v4FRSmjHXJ6tWslKwlViMohPei3kmYCBnoS4l88AXWv0IRtkq1Mw=
Message-ID: <9a8748490607100614h7e95e4b9jc4834dd568c9201e@mail.gmail.com>
Date: Mon, 10 Jul 2006 15:14:48 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH 9/9] -Wshadow: fixes for drivers/char/keyboard.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000607100607i47980d08w60a85be9aeca348@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607101313.42962.jesper.juhl@gmail.com>
	 <d120d5000607100607i47980d08w60a85be9aeca348@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 7/10/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > -static void kbd_keycode(unsigned int keycode, int down,
> > +static void kbd_keycode(unsigned int keycode, int _down,
> >                        int hw_raw, struct pt_regs *regs)
> >  {
>
> I dont like the "_down" name, feels artificial. If you don't mind I'll
> change it to "key_down" before applying.
>
Makes sense. Thank you for that feedback.
Working out if people liked the sort of name changes I'd done was
exactely one of the reasons I posted these patches - I'll think of
better names than just prefixing with "_" for future patches.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

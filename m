Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVL2XTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVL2XTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVL2XTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:19:05 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:45181 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751125AbVL2XTE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:19:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WMDnsiinywMmUIrmSgegH7i7IqbLEnNkYFqrtKr7sEM2qLN+qoocETQRZcxxdCyGY9qC8neP0y7CNgX+YKeUoTVzWhbUeR1Vcx+PQPIB1iOCrNr2RjYX6vIphJSFzSIaMEJezpgvJtyfpCbCDLWvYuQeX7mzwr6wBWpkrseSeWQ=
Message-ID: <9a8748490512291519h22c3ad6fvcda35fb038d0f3cf@mail.gmail.com>
Date: Fri, 30 Dec 2005 00:19:03 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: gcoady@gmail.com
Subject: Re: 2.6..15-rc7: CONFIG_HOTPLUG help text
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <drq8r15vvepe8ike7tkm5mkcfp41npph2h@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <drq8r15vvepe8ike7tkm5mkcfp41npph2h@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> Hi there,
>
> "
> CONFIG_HOTPLUG:
>
> This option is provided for the case where no in-kernel-tree
> modules require HOTPLUG functionality, but a module built
> outside the kernel tree does. Such modules require Y here.
> "
>
> This gives no indication it is required for udev.  Or is it me confused?
>
It doesn't mention udev specifically, but it does say quite clearly
that it's for out-of-kernel stuff that requires hotplug, and udev is
such a thing.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

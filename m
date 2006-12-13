Return-Path: <linux-kernel-owner+w=401wt.eu-S964986AbWLMOBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWLMOBd (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWLMOBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:01:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:35734 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964983AbWLMOBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:01:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qGyFqJe/kqnUk/axh9S1eFqBx9QZFwFAAfpRhJVNDIz5vT0mhyuRJhB61f9oxP9qIyFDy4pMyiX2ABTJnIZzYv3T7pyXz61HfHXjdK62ydv08MEj/H+aKVuvqfqWpHbHL6iKnlrSQCcUrD0bgE81Luy3lyOMGmZJVZcYegKC9KI=
Message-ID: <58cb370e0612130601w72c4cf73m45f26c74103f2231@mail.gmail.com>
Date: Wed, 13 Dec 2006 15:01:29 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Cc: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>, akpm@osdl.org,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061213113248.06372806@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	 <20061212234145.557cb035@localhost.localdomain>
	 <58cb370e0612121709x41270fb2p20280cc1edc9c533@mail.gmail.com>
	 <20061213113248.06372806@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > > Waste of space having a busproc routine. The maintainer removed all the
> > > usable hotplug support from old IDE so this might as well be dropped.
> >
> > I took over IDE when hotplug was already broken (late 2.5), moreover IDE
> > hotplug support has been always a quick hack according to its original author...
> > I remember your great efforts to fix it but unfortunately they
> > depended on executing
> > ioctls on non-existing devices which made them depend on layering
> > violation in 2.6,
>
> Bart, I'm really not interested in a 500 email rehash of the fact you
> chose to refuse the hotplug support (that was working) for 2.6.x. You
> did, the world has moved on, and there is no point putting a busproc
> function in that driver.

Unfortunately it seems that not everybody has moved on.  It is not
about your not accepted patches but about "the maintainer removed
all the usable hotplug support from old IDE" false accusations which
are unproven and untrue.

Bart

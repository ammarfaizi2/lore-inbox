Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVKSNoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVKSNoa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 08:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVKSNoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 08:44:30 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:48047 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751110AbVKSNo3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 08:44:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gD3QmshDKbXV8tMRvEihE/RtMboYpZ1D8PYbIoAys5nC8j23NG5xEtaYdyuCEvCnB5qMo/ZBe/uUdY5Aj1o3RQqUuZ31HFeWW30D10TVEXSsE85oGrWVEaA9puHABV9rN8tb5/MYRhrgk2ucykZgfP5WoGCGG8hiUFVmGy6Dhuo=
Message-ID: <9a8748490511190544k86a616by5918de40fc89a5cf@mail.gmail.com>
Date: Sat, 19 Nov 2005 14:44:28 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051117175015.6aa99fcf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051118014055.GK11494@stusta.de>
	 <20051117175015.6aa99fcf.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/05, Andrew Morton <akpm@osdl.org> wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated
> > on i386.
> >
>
> Problem is, nobody's fixing these things.  There's no point in adding spam
> to the kernel build unless it actually gets us some action, and I haven't
> seen any evidence that it does.
>
I for one was not aware that these functions were considered to be
deprecated, some log "spam" would have alerted me to that fact.

I'll take a look at fixing up some of these, just need to go dig up
some docs on what the replacements are first, so be patient...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

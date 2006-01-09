Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWAIWte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWAIWte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 17:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWAIWte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 17:49:34 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:19290 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751605AbWAIWtd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 17:49:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TkrHZuVEIFV+5bV9te79wPSxo8zy1okZzA97f93rIvw7qxHSpTxK3mZFZovrQOvPsSVAspo911kBj/Eg6NJsd7zX+kn1m/O7OwNrO5+6IGZh/eSNZeCe6Xq4SCjr6cAl1thVna1GYX5CGXDp7MtpnBWBlYDwOaweyXN+UZvDVh4=
Message-ID: <9a8748490601091449o23b18e52u76727caeab74747b@mail.gmail.com>
Date: Mon, 9 Jan 2006 23:49:32 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Dillow <dave@thedillows.org>
Subject: Re: Athlon 64 X2 cpuinfo oddities
Cc: LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <1136838548.6029.4.camel@dillow.idleaire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601091218m1ff0607h79207cfafe630864@mail.gmail.com>
	 <1136838548.6029.4.camel@dillow.idleaire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Dave Dillow <dave@thedillows.org> wrote:
> On Mon, 2006-01-09 at 21:18 +0100, Jesper Juhl wrote:
> > Second thing I find slightly odd is the lack of "sse3" in the "flags" list.
> > I was under the impression that all AMD Athlon 64 X2 CPU's featured SSE3?
> > Is it a case of:
> >  a) Me being wrong, not all Athlon 64 X2's feature SSE3?
> >  b) The CPU actually featuring SSE3 but Linux not taking advantage of it?
> >  c) The CPU features SSE3 and it's being utilized, but /proc/cpuinfo
> > doesn't show that fact?
> >  d) Something else?
>
> Can't help you with the rest, but SSE3 is called "pni" in cpuinfo for
> historical reasons, IIRC.

Ahh yes, PNI as in Prescot New Instructions - right?
Hmm, someone really ought to rename that to sse3 these days.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

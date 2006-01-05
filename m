Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWAEQw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWAEQw0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWAEQw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:52:26 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:36914 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751801AbWAEQwZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:52:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E+2I7m+WSkszR2Kqx2iYPLIfyKY3PZ9b3dDr8Spm6LtpE+dTFVNteFgAqcDhKGMuOpca4XwZ5SOmgbawJE3DabqyaGZfuXBwZLnippq9HsRaOC0LQ3DKAAesVJogSa3/bZsHOQbpR8VQQpHqJO3OgC6Ykx66RA3FlYw4Uk99wF4=
Message-ID: <9a8748490601050852t1e10ea6evd8769f2f4719186c@mail.gmail.com>
Date: Thu, 5 Jan 2006 17:52:23 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: bug reports ignored?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <38150.145.117.21.143.1136477335.squirrel@145.117.21.143>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38150.145.117.21.143.1136477335.squirrel@145.117.21.143>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Folkert van Heusden <folkert@vanheusden.com> wrote:
> Hi,
>
> Last couple of weeks I sent 2 bug-reports. They seem to be ignored. I was
> wondering: what is missing in them? Am I sending them to the incorrect
> address? One I also put into bugzilla (no reactions either).
>
Perhaps you could let us know the subjects & dates of those two
previous mails so they are easier to locate in the archives?

Speaking of bug-reports in general I believe the following holds pretty well :

 - Sometimes bug-reports simply get lost in the flood of emails. This
is especially true if they are only send to lkml and not Cc'ed to the
proper maintainers/authors of the code involved. A well researched
list of recipients (including LKML) greatly increases the chance of a
reply.

 - Sometimes bug-reports don't contain enough info to be able to say
anything useful. People are less inclined to respond to bug reports
like that since it often ends up with developers having to play "20
questions".

 - Sometimes bugs are reported for Tainted kernels, these often just
get ignored. Reproduce the problem with an un-tainted kernel and
people will be more inclined to listen.

 - Sometimes bugs are reported with a *demand* that it be fixed *right
now* or with other abusive language towards developers in the email.
Such reports are usually ignored or, if responded to, don't get very
positive replies.

Then there's also the situation where a lot of people actually do see
the report but don't feel they have anything useful to say on the
issue since it's outside their area of expertiese - a better Cc list
often helps :)

Most of the time I think it's just a case of too much mail and things
get missed unintentionally. Try again, possibly with a better
researched list of recipients and more details about the problem -
eventually the right people will notice :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

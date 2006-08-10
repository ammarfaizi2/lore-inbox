Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWHJXL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWHJXL4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWHJXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:11:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:24614 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932215AbWHJXLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:11:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QfORFcmjYF55B4FiVJt/SZgKbNAytTXjdFdULpzJQl+uogMf1Rlo4y5CeG3sd1Qj8L4HQCM8qFbZpACtbY0frjT5ccsh0PNQAg/0POdZl42l1CqS/WCCRzidcbB5pRMBlD49vPxX4QulJO9gq0bnJ3s0Z6pzIsR+qH7VQacfKFE=
Message-ID: <9a8748490608101611x2e4eaa42qe987535031d27213@mail.gmail.com>
Date: Fri, 11 Aug 2006 01:11:53 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers (version 2)
Cc: "Greg KH" <gregkh@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       "Robert Love" <rlove@rlove.org>,
       "Shem Multinymous" <multinymous@gmail.com>,
       linux-kernel@vger.kernel.org, "Pavel Machek" <pavel@suse.cz>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060810230545.84bbcb45.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155203330179-git-send-email-multinymous@gmail.com>
	 <acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com>
	 <20060810131820.23f00680.akpm@osdl.org>
	 <20060810203736.GA15208@suse.de>
	 <20060810230545.84bbcb45.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/06, Jean Delvare <khali@linux-fr.org> wrote:
> All,
>
> > On Thu, Aug 10, 2006 at 01:18:20PM -0700, Andrew Morton wrote:
> > > On Thu, 10 Aug 2006 09:46:47 -0400
> > > "Robert Love" <rlove@rlove.org> wrote:
> > >
> > > > Patches look great and I am glad someone has apparently better access
> > > > to hardware specs than I did.
> > >
> > > This situation is still a concern.  From where did this additional register
> > > information come?
> > >
> > > Was it reverse-engineered?  If so, by whom and how can we satisfy ourselves
> > > of this?
> > >
> > > Was it from published documents?
> > >
> > > Was it improperly obtained from NDA'ed documentation?
> > >
> > > Presumably the answer to the third question will be "no", but if
> > > challenged, how can we defend this assertion?
> > >
> > > So hm.  We're setting precedent here and we need Linus around to resolve
> > > this.  Perhaps we can ask "Shem" to reveal his true identity to Linus (and
> > > maybe me) privately and then we proceed on that basis.  The rule could be
> > > "each of the Signed-off-by:ers should know the identity of the others".
> >
> > For what it's worth, I'm not going to be handling these patches at all
> > (normally the hwmon patches go to Linus through Jean and then through
> > me.)
>
> I said it in private before, and I say it publicly again: I am not
> handling these patches either. I don't even want to read them.
>
> > If the original developer does not want to work in the open like the
> > rest of us, I can respect that, but unfortunatly I can't accept the risk
> > of accepting their code.
> >
> > And no, this is not "been beaten over the head by IP lawyers for three
> > years about risks like this" portion of me talking, although that side
> > does have a lot he could say about this situation...
>
> As far as I am concerned, even the real name of the person who wrote
> and sent these patches wouldn't be enough for me to take them. I would
> ask for an explanation of how that person got access to information
> about the HDAPS which even the original author of the driver didn't
> know about. And I would ask for proofs of that explanation.
>

As the person who wrote the initial version of the driver (not the
only one, other people wrote versions at the same time, but mine was
the one that was the basis for what Robert took over and what got
merged in mainline) I'd also be interrested in where this person got
his/her info from. I looked long and hard for docs and send lots of
emails to IBM and others requesting info (unsuccessfully), all I could
ever find was http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
 which is then what I used to write the initial driver from.


> All this is very unlikely to happen as I understand it, and anyway it's
> all too late. Regardless of its technical merits, this patchset has too
> much legal uncertainty attached to it by now. I'm maintaining the hwmon
> subsystem on my own time and money, it's painful and unrewarding enough
> as it is without adding legal hazard into the picture.
>
Maybe if the person behind these patches could do the following

1) Come out with his/her real name.
2) Provide detailed information about what sources of info these
patches are based on.
3) Provide names and contact info for people at IBM/Lenovo/the company
who made the gyroscope (can't remember who they are) etc etc, so that
we can contact them and verify these patches are based on stuff that's
OK.

then we could accept the patches...


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

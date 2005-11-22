Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVKVGGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVKVGGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 01:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVKVGGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 01:06:49 -0500
Received: from web81904.mail.mud.yahoo.com ([68.142.207.183]:29785 "HELO
	web81904.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932096AbVKVGGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 01:06:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZqjVuh11PDHJTHo216ILdrg9CM+XFc8cDuLQhZSCTnNTF/gStzZ4eOAHujBIQ3qSqbWkE/tl7z7cToDheNttHr2VeqzZ6oj90FeR79LGC9vCfb88VLphYySwuwf8N3tRX/iB3G+vd/lVAM7q2JrkPS6VYtWiskN/+pTcXARz9Qg=  ;
Message-ID: <20051122060648.8827.qmail@web81904.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 22:06:48 -0800 (PST)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: [RFC] Documentation dir is a mess
To: Marc Koschewski <marc@osknowledge.org>,
       Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <20051121173404.GA7886@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Marc Koschewski <marc@osknowledge.org> wrote:

> * Steven Rostedt <rostedt@goodmis.org> [2005-11-20 20:56:59 -0500]:
> 
> > On Sun, 2005-11-20 at 16:30 -0800, Greg KH wrote:
> > > On Sun, Nov 20, 2005 at 01:19:09PM +0100, Xose Vazquez Perez wrote:
> > > > hi,
> > > > 
> > > > _today_ Documentation/* is a mess of files. It would be good
> > > > to have the _same_ tree as the code has:
> > > 
> > > Do you have a proposal as to what specific files in that directory
> > > should go where?  Just basing it on the source tree will not get
> > > you very far...
> > 
> > Actually I think it's a good start.  When I'm looking for
> > documentation, I usually just do a grep -r on the Documentation
> > directory hoping I get a correct hit and then manually look 
> > through all the results I get. 
> > It does get tedious, and I miss things all the time.
> 
> As you're just about to maybe make a decision on reorganisation: how
> about a separation of user- and developer-relevant documentation? 
> I mean, kernel boot parameters are relevant to a user whereas 
> mm/* stuff is not.

There's a problem in the general conception that user/developer is a
mutex.  The whole idea is that anyone may become a developer at will.  A
division of Documentation/ to make an artificial distinction that the
community doesn't necessarily believe in doesn't seem too useful.

Now, I don't mean to suggest that you're wrong; I'm sure you have a valid
point.  If I may rephrase, it sounds more like you're looking for
"fingertip reference" versus "in-depth documentation".  The documents
that exist may not conform themselves well to that sort of division,
necessarily.  However, I'm sure that there exist fingertip references
outside of Documentation/ and the kernel tree; many of them are for
'newbies'.

Is this a useful interpretation?  Would an incorporation of this sort of
functional division meet your request?  Does anyone have the time to
devote to it?  Am I just reading out of the bit bucket?

Matt

> 
> Marc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131267AbRBLVuO>; Mon, 12 Feb 2001 16:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131479AbRBLVty>; Mon, 12 Feb 2001 16:49:54 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:16393 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131426AbRBLVtj>; Mon, 12 Feb 2001 16:49:39 -0500
Date: 12 Feb 2001 22:39:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: matti.aarnio@zmailer.org
cc: linux-kernel@vger.kernel.org
Message-ID: <7vh2Hebmw-B@khms.westfalen.de>
In-Reply-To: <20010212133324.B15688@mea-ext.zmailer.org>
Subject: Re: lkml subject line
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010212133324.B15688@mea-ext.zmailer.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matti.aarnio@zmailer.org (Matti Aarnio)  wrote on 12.02.01 in <20010212133324.B15688@mea-ext.zmailer.org>:

> On Mon, Feb 12, 2001 at 11:20:40AM +0000, Guennadi Liakhovetski wrote:
> > Dear all (and list maintainers in particular)
> >
> > Wouldn't it be a good idea to prepend all lkml subjects with [LKML] like
> > many other lists do to distinguish lkml messages from the rest.
>
>   NO!

Indeed. What a bad idea that would be.

>   If you want to pre-filter messages traveling thru  linux-kernel  list,
>   all you need to do is to check the content of   Return-Path:  header.

On the other hand, that's also not a very good scheme. There *is* a good  
way to do this, and it would be really nice if vger could be taught to do  
it: add a List-Id: header (draft-chandhok-listid-04.txt RFC-to-be,  
implemented in lots of mailing list managers already).

Examples from that doc:

    List-Id: List Header Mailing List <list-header.nisto.com>
    List-Id: <commonspace-users.list-id.within.com>
    List-Id: "Lena's Personal Joke List"
             <lenas-jokes.da39efc25c530ad145d41b86f7420c3b.021999.localhost>
    List-Id: "An internal CMU List" <0Jks9449.list-id.cmu.edu>
    List-Id: <da39efc25c530ad145d41b86f7420c3b.052000.localhost>

>   Or perhaps my utter aborrence is due to the way how GNU MAILMAN handles
>   that tagging (badly, that is).

Mailman, incidentally, _has_ List-Id: support.

> /Matti Aarnio  -- vger postmaster, not listmaster

Still ...


MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/

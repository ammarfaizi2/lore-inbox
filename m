Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266865AbSKHRxP>; Fri, 8 Nov 2002 12:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266866AbSKHRxP>; Fri, 8 Nov 2002 12:53:15 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:8067 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S266865AbSKHRxO> convert rfc822-to-8bit; Fri, 8 Nov 2002 12:53:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: nwourms@netscape.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-streams registration 2.5.46
Date: Fri, 8 Nov 2002 17:59:52 +0000
User-Agent: KMail/1.4.3
References: <5.1.0.14.2.20021107145447.027905c8@localhost> <200211080637.06511.landley@trommello.org> <aqgjr9$8d4$1@main.gmane.org>
In-Reply-To: <aqgjr9$8d4$1@main.gmane.org>
Cc: dave@gcom.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211081759.52061.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 November 2002 15:07, Nicholas Wourms wrote:

> > Just a random comment, but the feature freeze was October 31st.  Is this
> > a repost of something we saw before then?
>
> Seems to me that it is.

That's why I asked. :)

> Besides, as patches go, this is *hardly* obtrusive
> and requires minimal changes to the kernel API.  It's not like he's asking
> to integrate the whole streams driver into the kernel.  I don't think the
> addition of this code will cause any new bugs to appear [the actual streams
> driver aside], do you?

The curse of 3 am posting, I thought the patch was about something else 
(generic syscall registration for third party modules as mentioned months ago 
on the list) in the 5 seconds I glanced at it.  Having now actually read the 
thing with both eyes focused, it's just sticking bodies on two already 
reserved syscalls, which is pretty low impact, yeah. :)

(Although this mechanism could be USED for generic syscall registration by 
third parties that don't intend to use streams, only want two syscalls, and 
don't care deeply about their arguments.  But it's exported GPL so that would 
only ever be likely to be used for debugging purposes...)

To answer the original question for Dave: Alan Cox has now seen it, so life is 
probably good for you.

> Cheers,
> Nicholas
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?

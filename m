Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSFDRbg>; Tue, 4 Jun 2002 13:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSFDRbf>; Tue, 4 Jun 2002 13:31:35 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:8694 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315334AbSFDRbe>; Tue, 4 Jun 2002 13:31:34 -0400
Date: Tue, 4 Jun 2002 13:31:35 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: sendfile64()?
Message-ID: <20020604133135.B9111@redhat.com>
In-Reply-To: <200205311553.g4VFrP300813@mail.pronto.tv> <20020604135805.GB9641@wiget.koelner.com.pl> <20020604172441.Q18899@mea-ext.zmailer.org> <20020604183606.P681@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sendfile64 is in 2.5.  A backport to 2.4 has also been ported; we 
just need to convince Marcelo to accept it for 2.4.20.

		-ben

On Tue, Jun 04, 2002 at 06:36:06PM +0200, Ingo Oeser wrote:
> On Tue, Jun 04, 2002 at 05:24:41PM +0300, Matti Aarnio wrote:
> >   It does not exist in (32 bit) kernel, mostly because it doesn't
> >   make much sense..    Implementing it should be trivial, once
> >   somebody can show real meaningfull use for it.
> 
> Copy over hard disk images, serving video files (not streams!),
> serving database blobs etc.
> 
> Doing this only involving pagecache is not beneficial at all?
> 
> I'm not an expert in this area, but this would be my preferred
> way to implement the above.
> 
> Regards
> 
> Ingo Oeser
> -- 
> Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
"You will be reincarnated as a toad; and you will be much happier."

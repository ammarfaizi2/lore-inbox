Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSFDRJu>; Tue, 4 Jun 2002 13:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315264AbSFDRJr>; Tue, 4 Jun 2002 13:09:47 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:41991 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315259AbSFDRJq>; Tue, 4 Jun 2002 13:09:46 -0400
Date: Tue, 4 Jun 2002 18:36:06 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile64()?
Message-ID: <20020604183606.P681@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200205311553.g4VFrP300813@mail.pronto.tv> <20020604135805.GB9641@wiget.koelner.com.pl> <20020604172441.Q18899@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 05:24:41PM +0300, Matti Aarnio wrote:
>   It does not exist in (32 bit) kernel, mostly because it doesn't
>   make much sense..    Implementing it should be trivial, once
>   somebody can show real meaningfull use for it.

Copy over hard disk images, serving video files (not streams!),
serving database blobs etc.

Doing this only involving pagecache is not beneficial at all?

I'm not an expert in this area, but this would be my preferred
way to implement the above.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

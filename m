Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWJQSjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWJQSjU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWJQSjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:39:20 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:27812 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751420AbWJQSjS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:39:18 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Joerg Schilling <Joerg.Schilling@fokus.fraunhofer.de>
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Date: Tue, 17 Oct 2006 21:39:26 +0300
User-Agent: KMail/1.9.5
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
References: <200610171445.k9HEji8R018455@burner.fokus.fraunhofer.de> <200610172128.20653.ismail@pardus.org.tr> <453521a4.QReHSjx3qh9sf0jr%Joerg.Schilling@fokus.fraunhofer.de>
In-Reply-To: <453521a4.QReHSjx3qh9sf0jr%Joerg.Schilling@fokus.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610172139.26853.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

17 Eki 2006 Sal 21:32 tarihinde, Joerg Schilling şunları yazmıştı: 
> Ismail Donmez <ismail@pardus.org.tr> wrote:
> > > Well, this is why I did offer a preliminary version of thelatest
> > > mkisofs sources.....
> >
> > Well a simple mkisofs some_file > test.iso and mounting that on a loop
> > device worked fine.
> >
> > > But note: your patch does not fix the original implementation bug and
> > > it is most unlikely that the hack will do the right things in all
> > > cases.
> >
> > Well I don't know whats the original implementation bug and rock.c seems
> > to be pretty much old with no active maintainer.
>
> Please read again my original mail....
>
> 1) you need to create images with Rock Ridge

Well tried -force-rr and it didn't generate Rock Ridge either.

> 2) a correct implementation is prepared to deal with more recent versions
> 	without a need for new changes.
>
> So, if the implementation does not deal with the new version _without_
> explicitely knowing about v1.12 it is still broken.

I am not sure how is this possible, maybe should check how OpenSolaris does 
this. No time for that now.

Regards,
ismail

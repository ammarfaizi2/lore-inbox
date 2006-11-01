Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946506AbWKACdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946506AbWKACdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946508AbWKACdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:33:14 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:60252 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946506AbWKACdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:33:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=OJthkGOBQT595hhL2yNumdD4S9AKidVRxz8UqLunNUlJeQqPCgaxTiuz1hGRLzPBb+WlovGCAbjktDKyZRUIFgmdfRRpAb47WalOJrRaTrZoC3tHww1GfJa0w0eQzKoY0IqL8AtX5xaPlyNZFWCJ2Pyq9ehi3zNsapQRLyL2R9Q=
Message-ID: <f46018bb0610311833x75001040md57341bc568a8902@mail.gmail.com>
Date: Tue, 31 Oct 2006 21:33:11 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Cc: "Holden Karau" <holdenk@xandros.com>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       "akpm@osdl.org" <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
In-Reply-To: <87odrst22f.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454765AC.1050905@xandros.com> <87mz7cqvd8.fsf@duaron.myhome.or.jp>
	 <f46018bb0610311046t6aa969ccy60a2020f7e5a0ed9@mail.gmail.com>
	 <87slh4tesh.fsf@duaron.myhome.or.jp>
	 <f46018bb0610311254u30063d57gebc2e0e190398c9@mail.gmail.com>
	 <87odrst22f.fsf@duaron.myhome.or.jp>
X-Google-Sender-Auth: 4bfcdb600c27df43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops, sorry about that. Yes it would improve performance on fat12 &
fat16 [although I haven't tested it with fat12]. What I meant by that
sentance is that, fat sync performance is pretty bad with or without
my patch, its just slightly less worse with my patch :-)

On 10/31/06, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> "Holden Karau" <holden@pigscanfly.ca> writes:
>
> > This patch is just meant to make fat32 sync performance better, not
> > necessarily make it usable for everyone [one step at a time and all
> > that].
>
> Sorry, I can't see your point. The FAT12 and FAT16 also have backup FAT.
> And the your patch didn't make performance better, right?
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>


-- 
Cell: 613-276-1645

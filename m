Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWIPGrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWIPGrh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 02:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWIPGrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 02:47:37 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:9110 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932208AbWIPGrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 02:47:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DsEdkLX2BzZLLBn+RMSED6xVQEphF2mx0x93t5dMzrpwh2bq9SAZoqYCEVvTFaFDZxpSdI3faKINjryJXMCEBvvMPkXGZUQCo3Qc08cjnxIFwsp/R/d0CABSsON6XEFMBmPtP1RqvgCNA+1/0ZDeb8w9bUQnFkXix2qjcSgLDvM=
Message-ID: <a52a95e30609152347h3d08a33pa75067e78445e0c0@mail.gmail.com>
Date: Fri, 15 Sep 2006 23:47:35 -0700
From: "Tom Mortensen" <tmmlkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
In-Reply-To: <20060916053713.GJ541@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com>
	 <20060916053713.GJ541@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the info.  In studying the code that's what my
impression was as well (that it would require a considerable effort).

I haven't encountered any problems with SATA in 2.4.33, but I guess
what I was concerned about was when/if it might become necessary to
migrate to 2.6.x in order to support newer hardware.  I guess I'll
know when I encounter it :)

On 9/15/06, Willy Tarreau <w@1wt.eu> wrote:
> On Fri, Sep 15, 2006 at 10:14:07PM -0700, Tom Mortensen wrote:
> > To Jeff Garzik & others,
> > I was wondering if there are any plans for another resync of the latest
> > 2.6.x libata changes back into the 2.4.x kernel?
>
> When Jeff posted his last version (which got merged), he said that it
> would be his last work on this backport. I've been regularly checking
> what has changed in 2.6, because often some bugs are fixed, but I see
> that the code has considerably evolved since the last resync, and I'm
> not even sure that those bugfixes are needed for 2.4.
>
> A full resync of latest 2.6 would require a considerable effort it seems.
> Do you encounter any problems right now ? I get very few feedback from
> SATA users in general.
>
> Regards,
> Willy
>
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWJAQnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWJAQnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWJAQnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:43:17 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:22604 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751245AbWJAQnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:43:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mGzsQvYO1aysl7Vd7Wag76MvFOe9UQ68fFQOgdQ4BCV8azM5WUNp/BxGYDHy59wy9S8ugEZmT58Go92va36Tw7WUo7A4RVU1GPwbGLFnfHeqHAJtN8Ftx2g/GAWNhTdgjLOu5vBzs6XqL9d0EEJmEYgXwhS5S8t7tHhR4fFVjYY=
Message-ID: <5bdc1c8b0610010943j42a8523dsfa08206a09bacb6d@mail.gmail.com>
Date: Sun, 1 Oct 2006 09:43:16 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: 2.6.18-mm1 violates sandbox feature on linux distribution
Cc: "Michael Rasenberger" <miraze@web.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061001104046.GA10205@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <451ABE0E.2030904@web.de>
	 <20061001104046.GA10205@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Sep 27, 2006 at 06:08:14PM +0000, Michael Rasenberger wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Hello,
> >
> > when building external kernel module on gentoo linux distribution,
> > 2.6.18-mm1 violates gentoo's sandbox feature due to file creation in
> > "as-instr" test in scripts/Kbuild.include. (AFAIK due to removal of
> > revert-x86_64-mm-detect-cfi.patch)
>
> Can you point to to some description of this sandbox feature.
> The error you point out looks pretty generic and should happen
> in several places - so I need to understand what problem I shall
> fix before trying to fix it.
>
> The point is that we have other places where we create temporary files
> so this should not be the only issue.
>
>         Sam

Hi,
   Some generic info supplied to folks who debug for Gentoo.

http://bugday.gentoo.org/sandbox.html

Hope this helps,
Mark

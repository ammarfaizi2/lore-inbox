Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRBMKMc>; Tue, 13 Feb 2001 05:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129837AbRBMKMW>; Tue, 13 Feb 2001 05:12:22 -0500
Received: from comunit.de ([195.21.213.33]:13898 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S129267AbRBMKMI>;
	Tue, 13 Feb 2001 05:12:08 -0500
Date: Tue, 13 Feb 2001 11:12:01 +0100 (CET)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: <haegar@space.comunit.de>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: lkml subject line
In-Reply-To: <Pine.LNX.4.33.0102130341580.1123-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.32.0102131107400.21378-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Mike A. Harris wrote:

[cc-list trimmed]

> That said, and while we're on the topic.. Does anyone have a
> *PERFECT* recipe for procmail to REMOVE the stupid [Dummy] things
> most GNU mailman lists and others prepend to the subject?

I am using the following to sort the suse-security-list (for example, I do
the same on all lists that tag something into the subject):

:0 fhw
* ^TO_suse-security@suse.com
| sed -e '/^Subject:/s/\[suse-security\] //'
:0 A:
SuSE-Security$MONTH


c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)


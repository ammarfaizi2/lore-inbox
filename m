Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135998AbRDVJdk>; Sun, 22 Apr 2001 05:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135965AbRDVJdb>; Sun, 22 Apr 2001 05:33:31 -0400
Received: from quechua.inka.de ([212.227.14.2]:50232 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S135998AbRDVJdR>;
	Sun, 22 Apr 2001 05:33:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <20010421114942.A26415@thyrsus.com> <9bsd33$peb$1@forge.intermeta.de>
Organization: private Linux site, southern Germany
Date: Sun, 22 Apr 2001 11:21:43 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14rG3s-0003uF-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's wrong with:
>
> <MAP NAME="CONFIG_ namespace cross-reference generator/analyzer"
>      URL="http://www.tuxedo.org/~esr/cml2"
>      STATUS="Maintained"
>      DATE="Sat Apr 21 11:41:52 EDT 2001">

What is wrong with that is that it's serious overkill.
In particular, this application does not need the ability to nest
tags, so what remains is a linear sequence of name=value pairs and the
complicated syntax buys you nothing.

(More formally: it doesn't need a context-free language, a regular
language is enough.)

Eric's suggestion is powerful enough to do the job and can be parsed
with one line of sed script.

The useful thing in your proposal is the ability to give multiple
attributes to one item, e.g. mail="addr" desc="addr". Even this can be
achieved much easier with a bit of syntactical convention, like always
giving mail addresses in <> with the rest of the line being comment.
Most of the stuff is for human consumption only anyway.

Olaf

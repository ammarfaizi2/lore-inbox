Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWGJRkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWGJRkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422728AbWGJRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:40:10 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:63493 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422727AbWGJRkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:40:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZYVWcjjj7K6Pu+g4wYc3cQAU0fyy8C6gE4vc9yxCjU/aZzvykHqsEZvDMhHNfl1HhZ6qSkd81yZtkcFb6p+9riwfGw9mgmaVp567726vtm28oh/1QnPcZmIod6Gf/Niyq7D0L41dNXFJEu8RoniseJNH5ISjgMVqrl77KGQbRJw=
Message-ID: <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com>
Date: Mon, 10 Jul 2006 12:40:07 -0500
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Automatic Kernel Bug Report
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060710081131.GA2251@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	 <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
	 <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
	 <20060709191107.GN13938@stusta.de>
	 <e1e1d5f40607091301j723b92bje147932a4395775c@mail.gmail.com>
	 <200607092019.k69KJt66005527@turing-police.cc.vt.edu>
	 <e1e1d5f40607091327y3db1cbdco89ebdb04cda60ce0@mail.gmail.com>
	 <20060710081131.GA2251@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!

Hi ! =)

>
> Well, unless we have some volunteer to go through the bugreports and
> sort them/kill the invalid ones/etc... this is going to do more harm
> than good.

As I told before, I wouldn't care to do that, as long as I know that
it is actually being used (and useful). The system (at the server
side) could automatically route some reports (mark them as "tainted
modules detected", etc, that sort of mechanical stuff), and according
to the frequency of certain bugs, I could check if they are actually
real bugs. If so, they get reported here on LKML. Since we can expect,
maybe, dozens of thousands of reports per week, wouldn't be hard to
distinct between real bugs, etc (if we use frequency as a marker). For
example, if the number of reports on Suspend2 get risen up sensitively
on some just-released kernel, this means that something that was added
isn't working (so here comes the personal debug, where we can see if
it's a new bug or a regression)

Daniel



-- 
What this world needs is a good five-dollar plasma weapon.

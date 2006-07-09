Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161048AbWGISq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWGISq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWGISq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 14:46:29 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:50272 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161048AbWGISq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 14:46:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rWHxhcI7QPcTH4nrcfhTHCK3gqqs9Q38GbxDyW3VAStSLOqxXToijRIzPhiDQPYJ7FJotN3CbiYJxMG9BwRo4alvucTOAJ/nW97jZWmXrGrn73O3mOKlzkia2wZU+7pOiipI4RuoQB/ZP5MgqZ65K5EkZEH6QOm9anbhXTbN0oc=
Message-ID: <e1e1d5f40607091146s2f8e6431v33923f38c6d10539@mail.gmail.com>
Date: Sun, 9 Jul 2006 14:46:28 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: Automatic Kernel Bug Report
Cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060709125805.GF13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e1e1d5f40607090145k365c0009ia3448d71290154c@mail.gmail.com>
	 <6bffcb0e0607090245t2dbcd394n86ce91eec661f215@mail.gmail.com>
	 <e1e1d5f40607090329i25f6b1b2s3db2c2001230932c@mail.gmail.com>
	 <20060709125805.GF13938@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm sorry for being so negative, but it seems you are overdesigning a
> solution for a non-existing problem:
>
> There are cases where the machine is simply dead with exactly zero
> information. These are the really hard ones.
>

Then really there isn't anything that we can do, except to expect the
kindness of the user in taking a picture of his screen and posting on
the kernel's bugzilla.

> Then there are cases where the kernel is able to print a BUG() or Oops
> to a log file. Or the error message is printed to the screen and the
> user uses a digital camera and sends the photo.

Then again, users may just continue using the machine (without even
noticing the Oops), or notice but never care to report it, or forgets,
etc.

> The message is usually enough for starting to debug the problem or
> asking the user for additional information.
>
> But most important, the problem lies in a completely different area:
>
> Interaction between kernel devlopers and users is not a real problem.
> The real problem is the missing developer manpower for handling bug
> reports.
>

Well Adrian, this is the other side of the problem. We don't actually
need a kernel monkey to keep looking for bugs that comes (even thought
would be good, but as you stated, there is not enough manpower to do
that), even more after having something that automatically sends Oops
reports to the server, where we could expect thousands of bug reports
daily... but I also believe that not having somebody to look at them
is not an excuse for not having this bug taken account for. For
example, even though we may not debug each and every bug report, we
can have statistics for which modules are reporting more problems (and
therefore, have more bugs). For example, I don't really expect
Microsoft to investigate every crash report that users send, but it is
definitely important to have bugs accounted for. Let's say that the
SCSI maintainer just did a big change to the SCSI subsystem and wants
to know how is it going: he just goes to bugzilla and see statistics
about increase of the ratio of bug reports compared to the last
version, or he can also see which functions (based on the EIP as a
guess) are reporting more problems.

In resume, don't being able to investigate each report isn't a reason
for not being acknowledged of its existance, and even we don't
investigate it, having it for statistical purposes is already a great
deal.

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.

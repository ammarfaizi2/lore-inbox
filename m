Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWJLL5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWJLL5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 07:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWJLL5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 07:57:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:24011 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750963AbWJLL5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 07:57:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gR3mSz/j939esXOlc8GK3saKXQ4mnoBC/IVTsmwLPACrYh/M54UV139OLFJVAhp1OW8QdK1McKyQUNO0+SlLa53J9Kfuloyzq2M0Vwr2Mqf4lbTf9Vlv7dIzCJmt+iLEDnsprdZPxd4dsNZYJXMmqgNmLwFuNkqP++Xw5oTKo7Q=
Message-ID: <84144f020610120457g221b8736vebf2f0a634480c05@mail.gmail.com>
Date: Thu, 12 Oct 2006 14:57:38 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: jplatte@naasa.net
Subject: Re: Userspace process may be able to DoS kernel
Cc: "=?ISO-8859-1?Q?G=FCnther_Starnberger?=" <gst@sysfrog.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610121341.56325.lists@naasa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <474c7c2f0610110954y46b68a14q17b88a5e28ffe8d9@mail.gmail.com>
	 <200610120802.59077.lists@naasa.net>
	 <84144f020610120430r382bc860t5092ddb2a343d2d9@mail.gmail.com>
	 <200610121341.56325.lists@naasa.net>
X-Google-Sender-Auth: 2ab4297058d78bb4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, Joerg Platte <lists@naasa.net> wrote:
> Hmmm, I deleted all my 2.6.16 kernels and I can't test a newly compiled 2.6.16
> kernel before the weekend. But if I remember correctly, on previous kernel
> versions skype just generates 100% system load when using the sound device
> after some time (especially after a resume) and stuttered audio but no system
> lockups. Hence, it worked much better than now from the kernel point of view
> but was not usable from the skype users point of view. It was a userspace
> only problem.

If that is the case, you can do git bisect to help us narrow down the
cause. See http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt
for further details.

                                                   Pekka

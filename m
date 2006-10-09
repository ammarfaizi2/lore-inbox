Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWJIHof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWJIHof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWJIHof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:44:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:8652 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932326AbWJIHoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:44:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IMfA5S5qE62M66Gwv2hVvrXwuz7bA1KfvRXSjezfh4TjaSnW0b2fvc6Bl/LI3bWr0HYRCaCjl1Xi/+xiACkRlQ3zOQELZyCAUVVCnrYnsIJ0OU3po7GEwnKhEaqrBwYh/dOzhVrArT2qzxXaQVURJyOUbRgVkvx3xYijibK5atk=
Message-ID: <215036450610090044n56ec3a9dg62573a16d63ab00c@mail.gmail.com>
Date: Mon, 9 Oct 2006 15:44:32 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: "Tejun Heo" <htejun@gmail.com>
Subject: Re: [PATCH] libata: skip reset on bus not a device
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>
In-Reply-To: <20061009070652.GE10832@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <215036450609292206pd16c7cxa1c5c77ee52c050e@mail.gmail.com>
	 <451E7BD2.7020002@gmail.com>
	 <215036450609301849h64551749uf6b4a3e48c57fe15@mail.gmail.com>
	 <4529BCC4.8060906@gmail.com>
	 <215036450610082354q34b906bdp54a3b9cee52a5855@mail.gmail.com>
	 <4529F391.3030504@gmail.com> <20061009070652.GE10832@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's against libata development tree.  So, you downloaded the tar.gz and
> > tested it?

no, but at latest kernel 2.6.19-rc1 use the same tree as you said, and
it also can worked


>
> And, one more thing to try.  The following patch should fix your
> problem.  It's against v2.6.18.
>

while applied the patch, error info gone :)

A question: if the status register return 0xFF means the device not exist?
why not use ata_devchk()?

thanks

-Joe

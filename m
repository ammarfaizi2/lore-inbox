Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVALAda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVALAda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVALAai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:30:38 -0500
Received: from mail1.edisontel.com ([62.94.0.30]:61592 "EHLO
	ims1.edisontel.com") by vger.kernel.org with ESMTP id S262967AbVALAI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:08:27 -0500
Message-ID: <41E46ACE.2040101@gmail.com>
Date: Wed, 12 Jan 2005 01:09:50 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, Nathan Lynch <nathanl@austin.ibm.com>
CC: vamsi_krishna@in.ibm.com, prasanna@in.ibm.com, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kprobes /proc entry
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com>
In-Reply-To: <20050111213400.GB18422@kroah.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH ha scritto:
> On Tue, Jan 11, 2005 at 03:31:17PM -0600, Nathan Lynch wrote:
> 
>>On Mon, 2005-01-10 at 12:14, Greg KH wrote:
>>
>>>On Mon, Jan 10, 2005 at 05:25:38PM +0100, Luca Falavigna wrote:
>>>
>>>>This simple patch adds a new file in /proc, listing every kprobe which
>>>>is currently registered in the kernel. This patch is checked against
>>>>kernel 2.6.10
>>>
>>>No, please do not add extra /proc files to the kernel.  This belongs in
>>>/sys, as it has _nothing_ to do with processes.
>>
>>Wouldn't this sort of thing be a good candidate for debugfs?  If you're
>>messing with kprobes, then aren't you by definition doing kernel
>>debugging? :)
> 
> 
> That's an even better idea, I like it.
> 
> greg k-h
> 

Good, I'll work on it ASAP.
Thank you for your suggestions!

					Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQeRqzRZrwl7j21nOAQJrFQf/RnBUDTsju6LLcYRdM6RYiyrnydTBJWtw
Q3MuNE9S/kiwmFpCJjshV9tazJ+dA29pxuqt+Wg2aGkqSSVgq8KuuF1uSLIlaatM
n0ZSZ/tnOEJoQtlI32azik+PYVQkHHcr2HMN5ruThRO3uCJfHuYZEGEGaUkZQRa+
ORGrVgXSoLVCQmenIOaXHDW1UNOdKb1IgyU4HBpjL8zVUWOLTB7jbtxghC5rDgHP
BV9AYP0GaeIb7Xy5l/bcfngU+teKE75ht+ew5xzX3Ee0Sz9G5a5YVvWJTecHSyeq
id4WK0etFHp8qufX/gcGr0uTY8gpxF8GCzwcU8KCr32Y6vvLlVKzxQ==
=BXBj
-----END PGP SIGNATURE-----

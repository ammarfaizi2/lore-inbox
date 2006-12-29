Return-Path: <linux-kernel-owner+w=401wt.eu-S1753561AbWL2Eh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbWL2Eh4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 23:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbWL2Eh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 23:37:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:26759 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbWL2Eh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 23:37:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aygJv8LVlwZo4tzUaUO2T4Cbb95ruImka5zc9TMTyM2xOh6auE2HCJ1ufsu0ESH+ryiyVzfiRfb5ZaqIYP3tbb3j4NE3AkbIkqdJxHyrAi2c9f6Ds9r5hZ8s6Wz5hkJMbqxTF/PhrYYACMMwo0/shiawZFFcxFhOijSMzgxzUp0=
Message-ID: <b6a2187b0612282037p16e3f355i8683f1cfbe0179b2@mail.gmail.com>
Date: Fri, 29 Dec 2006 12:37:54 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Dor Laor" <dor.laor@qumranet.com>
Subject: Re: open /dev/kvm: No such file or directory
Cc: lkml <linux-kernel@vger.kernel.org>, "Greg KH" <greg@kroah.com>
In-Reply-To: <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>
	 <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net>
	 <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/06, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> > Are you sure the kvm_intel & kvm modules are loaded?
> > Please check your dmesg.

I checked and it's loaded ...

Module                  Size     Used by
kvm_intel              18572  0
kvm                      46276  1 kvm_intel

Any chance of getting a static /dev/kvm ?

Thanks,
Jeff.

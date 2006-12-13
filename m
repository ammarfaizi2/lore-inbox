Return-Path: <linux-kernel-owner+w=401wt.eu-S1750764AbWLMUiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWLMUiH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWLMUiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:38:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:29316 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbWLMUiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:38:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OprqMmlW3YhnLubhgiXZ2adGX4IN/48S2Ee7Uj8MPN4v+eQXPI1x6SHX/VUipRfeL5bk0VqlJuLhK3c9iQYEEuOhPuSFrD7/3rjSbHf+q62/5402qY29CmB6JNZG0VUZ7+ZgDDXYRfBN/SN+AzJPS/0nhs56Lo3D2xZjBHRmnFo=
Message-ID: <f2b55d220612131238h6829f51ao96c17abbd1d0b71d@mail.gmail.com>
Date: Wed, 13 Dec 2006 12:38:05 -0800
From: "Michael K. Edwards" <medwards.linux@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Cc: "Greg KH" <gregkh@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Ok, what kind of ass-hat idiotic thing is this?

C'mon, Linus, tell us how you _really_ feel.

Seriously, though, please please pretty please do not allow a facility
for "going through a simple interface to get accesses to irqs and
memory regions" into the mainline kernel, with or without toy ISA
examples.  Embedded systems integrators have enough trouble with chip
vendors who think that exposing the device registers to userspace
constitutes a "driver".  The correct description is more like "porting
shim for MMU-less RTOS tasks"; and if the BSP vendors of the world can
make a nickel supplying them, more power to them.  Just not in
mainline, please.

Cheers,
- Michael

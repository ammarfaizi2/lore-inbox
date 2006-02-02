Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWBBTxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWBBTxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWBBTxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:53:55 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:61514 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751132AbWBBTxz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:53:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jOZkT8glmBWnpu4xE2t0gFNeRybcNYHJWVcPRHk9XdfFyol5UICPYEG8EHXplohOP0SGWYZf/ZAZfULBoIThpMXFBjWe6gtGb/h6ci5cYhS/SbfJuqwtxgUbCCHZIGkpntgncFqR6gzpQCOzu/mzHGb4trqEyTF35hX/1APdcWs=
Message-ID: <84144f020602021153w477311f8t70f953c78d3e251@mail.gmail.com>
Date: Thu, 2 Feb 2006 21:53:53 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
In-Reply-To: <20060202192414.GA22074@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060202192414.GA22074@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/06, Dave Jones <davej@redhat.com> wrote:
> In the case where we detect a single bit has been flipped, we spew
> the usual slab corruption message, which users instantly think
> is a kernel bug.  In a lot of cases, single bit errors are
> down to bad memory, or other hardware failure.
>
> This patch adds an extra line to the slab debug messages in those
> cases, in the hope that users will try memtest before they report a bug.
>
> 000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Single bit error detected. Possibly bad RAM. Please run memtest86.
>
> Signed-off-by: Dave Jones <davej@redhat.com>

Looks good to me.

                          Pekka

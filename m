Return-Path: <linux-kernel-owner+w=401wt.eu-S1754296AbWL3Kin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbWL3Kin (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 05:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754291AbWL3Kin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 05:38:43 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:35088 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbWL3Kim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 05:38:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GXomD2qXDnSYfOjbYM4PQKXTMt7n/P82oHfW78cGl2nPI0rnruKzNquiuIijolqBL6GbGijEOC2aamr6CYhZFUBtKPQ0/pE4blHMPwbHbfipYjBL9lc2sENkx75eDhXTQ+K2N3M3M+/7FWdJ6U2E7GZtwClwjoQB99TvLijyI5Q=
Message-ID: <8bd0f97a0612300238v68c89374w1f7ce1a25d703f1c@mail.gmail.com>
Date: Sat, 30 Dec 2006 05:38:41 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: make headers_install headers problem on sparc64
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <1161257672.3428.3.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061018223713.GD9350@pelagius.h-e-r-e-s-y.com>
	 <20061019105441.GC17882@pelagius.h-e-r-e-s-y.com>
	 <20061019111037.GD17882@pelagius.h-e-r-e-s-y.com>
	 <1161257672.3428.3.camel@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/06, David Woodhouse <dwmw2@infradead.org> wrote:
> No. That header should not be exposed to userspace. Just fix
> reiserfsprogs instead. It's not as if unaligned access is _hard_ -- you
> just have to ask the compiler to do it for you:

reiserfsprogs 3.6.20 already handles the case where asm/unaligned.h
isnt installed ... i just wouldnt suggest using that version as it
wont even compile on big endian machines and doesnt work with
non-standard journals ;)
-mike

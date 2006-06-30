Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWF3DuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWF3DuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 23:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWF3DuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 23:50:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4546 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750869AbWF3Dt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 23:49:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hJJ3joOtUWnPKWb3lJ6LjRt+GRn+tNnp/YwekLL7Zj7RW3ezaFKOkAS+/HWGCCfCCx/8g3dS8XFzUPTSWbCdZ2viehdYL3qGL866qN1NFOJnMGGCQyA/2zPer0bOiY/qRdVuqnAKiD0vvKR7kDFfgmknqeK/8rREjXHHpAsCEp8=
Message-ID: <a36005b50606292049j74989addsc94a1f91ebce6ecb@mail.gmail.com>
Date: Thu, 29 Jun 2006 20:49:57 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: make PROT_WRITE imply PROT_READ
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Jason Baron" <jbaron@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060629073033.GF27526@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <449B42B3.6010908@shaw.ca>
	 <1151071581.3204.14.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606231002150.24102@dhcp83-5.boston.redhat.com>
	 <1151072280.3204.17.camel@laptopd505.fenrus.org>
	 <a36005b50606241145q4d1dd17dg85f80e07fb582cdb@mail.gmail.com>
	 <20060627095632.GA22666@elf.ucw.cz>
	 <a36005b50606280943l54138e80tbda08e1607136792@mail.gmail.com>
	 <20060628194913.GA18039@elf.ucw.cz>
	 <a36005b50606281647i58f2899eo7ae7e95757969d42@mail.gmail.com>
	 <20060629073033.GF27526@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Pavel Machek <pavel@suse.cz> wrote:
> Can you quote part of POSIX where it says that PROT_WRITE must imply
> PROT_READ?

I never wrote that.  What POSIX does specify is that PROT_READ can
optionally be implicitly set.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWHHUn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWHHUn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWHHUn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:43:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:19080 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWHHUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:43:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCPQuDka2ibKRdtO/T6dBuKlXzOVVose1uydHJw/yadOb7+nhqViNe5oAF5IgU0Q+IAmoxzQ3gkBH9VELbNvDmIeinudk3D3PzDr/lRc20x6ZaH2HgQc/gqU/amwxRkvGM0VtaSlzQXg+LKsKzMjP2++ErIdR8a45ogOR/1YEPk=
Message-ID: <a762e240608081343r3816b906o7985bde9fbd9b463@mail.gmail.com>
Date: Tue, 8 Aug 2006 13:43:57 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: Double the per cpu area size
Cc: "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1vep4ecd8.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1mzagfu03.fsf@ebiederm.dsl.xmission.com>
	 <200608071730.47120.ak@suse.de>
	 <m1vep4ecd8.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Andi Kleen <ak@suse.de> writes:
>
> >>
> >>  #include <asm/pda.h>
> >>
> >> +#define PERCPU_ENOUGH_ROOM 65536

Is it possible to put this into -mm untill things are sorted?
2.6.18-rc3-mm2 x86_64 is still without any per-cpu space for modules.

Thanks,
  Keith

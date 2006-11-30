Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967826AbWK3DeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967826AbWK3DeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 22:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967821AbWK3DeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 22:34:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:33822 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S967826AbWK3DeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 22:34:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jq0RDtGQ3DxwIdjC7Rv1AaLFhV6koZLFcRBM8KKhCZOpgPsRnsvbmJgXfLY/xd5poSZqMkiBdwS0yttixHIkKsdP3VRKeiyrNyP6OpIAzuHfp2HKqNFeAdTBJK8/GlA97Hdft81VEQV6GpBJUnESAkSdKFyp9ru+Z7a8qBWHxIk=
Message-ID: <ac8af0be0611291934x209a3be0t70ec8fb286d4b415@mail.gmail.com>
Date: Wed, 29 Nov 2006 19:34:20 -0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: A commit between 2.6.16.4 and 2.6.16.5 failed crashme
Cc: "Andi Kleen" <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061129083310.GC11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ac8af0be0611290018y70c68a66r5a3199f08e6417d5@mail.gmail.com>
	 <20061129083310.GC11084@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks for your report.
>
> A git-bisect might be a bit of overkill considering that there were only
> two patches applied beween 2.6.16.4 and 2.6.16.5:
>
> Andi Kleen (2):
>       x86_64: Clean up execve
>       x86_64: When user could have changed RIP always force IRET (CVE-2006-0744)
>
> I've attached both patches.
>

Hi Andi,

I found that this patch is also in 2.6.18.3, but crashme doesn't
trigger kernel panic for 2.6.18.3......weird.

Thanks,
Forrest

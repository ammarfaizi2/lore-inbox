Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUIORiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUIORiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUIORhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:37:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1982 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267199AbUIORf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:35:57 -0400
To: hari@in.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       litke@us.ibm.com
Subject: Re: [Fastboot] kexec based crash dumping
References: <20040915125041.GA15450@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Sep 2004 11:33:04 -0600
In-Reply-To: <20040915125041.GA15450@in.ibm.com>
Message-ID: <m14qlzbfov.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> writes:

> Hi Andrew,
> 
> The patches that follow contain the kexec based crash dumping implementation.
> Based on feedback received last time, we have made several changes. Some of
> them are:
> 
> - The dumping kernel now boots from a non-default location. This is possible
>   due to Eric's patch which allows i386 kernels to boot from a non-default
>   location. This change means that we need two different kernels to get this
>   setup. The documentation patch has complete details on how to do this.

Cool.  I am glad you could get this going this should make things
easier.

> - We can now choose whether or not to dump from panic. The documentation
>   patch has details on this as well.
> - The linear view is now called oldmem.
> - Changes as per the code review comments from the previous posting.
> 
> The patches correspond to 2.6.9-rc1-mm5.
> 
> Kindly review these patches and let me know your thoughts.

I will start with my standard objections about it still being
incompatible with other uses of kexec.

More later when I get a chance.  Things seem to slowly be going
in the right direction.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVHVWcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVHVWcg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVHVWcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:32:35 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45960 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751376AbVHVWWe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BAtDaEWMB+LJWj37O+yu0VZtbeo+xqDvQyylWzmsHmoITCx/F5/129E5lMUOrzu/Ai+qcf6oIDAxYp6ywJ2JMfbSIxXd8rF439vnWSihGxrTtxndMHvNq4pIuPuTc9EoQy4N6RpwVxv1RzvCT2HWYyhtuA/mfqRKBJbHjGCcmHY=
Message-ID: <4fec73ca05082202051231bf15@mail.gmail.com>
Date: Mon, 22 Aug 2005 11:05:32 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Environment variables inside the kernel?
Cc: Linh Dang <linhd@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m1fyt3ueh9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	 <m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
	 <wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
	 <4fec73ca05081811488ec518e@mail.gmail.com>
	 <m1fyt3ueh9.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
> ??
> Usually when I hear stand-alone program I think of program that runs
> without the need of a kernel.  You have an environment in that context?

Without the need of a kernel? Perhaps I did not explain myself
correctly... I meant a user space program, is that better?

And yes, there is a environment in this context, but it is feasible to
provide the information it contains through module parameters.

> Be very careful.  Generally I think at least until the filesystem
> is very stable running your filesystem server in the kernel is a mistake.
> 
> And the concept of a parallel filesystem with just one server just
> sounds wrong from any context.

Thanks for the advise, but do not worry, the servers run outside the
kernel (preferably outside the host :). It is the client side what is
to be integrated into the kernel.

Regards,

-- 
Guillermo

Return-Path: <linux-kernel-owner+w=401wt.eu-S1761788AbWLIONV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761788AbWLIONV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761789AbWLIONV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:13:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:42981 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761786AbWLIONU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:13:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hSIyBhh2vSq/6TFhBMm1OLEJqpVWIGLyWu9DOM6Mh7n6Pj+YccKe2xjMz+T50lkwJFYnGPpJuDShOq/IZODOPqoOy0JAVblCPBoNS5xMplaJDRqS/7YLcWjOosGjf4ZG05BwOBdnHxsQpWtx84eUsFvLSUGU1uFIbrzQgWcFLrA=
Message-ID: <84144f020612090613s28aeb485ua7c652393cff3f90@mail.gmail.com>
Date: Sat, 9 Dec 2006 16:13:16 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to kcalloc().
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612090855590.14206@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
	 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
	 <Pine.LNX.4.64.0612090855590.14206@localhost.localdomain>
X-Google-Sender-Auth: 532dd8e17075aa92
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> argh, in that i've already mentioned that, following the guidelines in
> "SubmittingPatches", i prefer that each of my patches have one logical
> purpose.  once the order of the kcalloc() args is corrected, that
> would be followed by a single subsequent patch that did the
> kcalloc->kzalloc transformation all at once.

...and what would that buy us? Nothing. It *really* wants to use
kzalloc and the transformation is equivalent, so please make it one
patch.

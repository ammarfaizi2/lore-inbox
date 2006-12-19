Return-Path: <linux-kernel-owner+w=401wt.eu-S932857AbWLSRmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbWLSRmo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbWLSRmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:42:44 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:55412 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857AbWLSRmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:42:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BfWgrUzLTKsocEkfUloAA1VkYu0Z0Tv6pBiBpaImZWXMNYISA6a6krRHCo2vVM4UZnKESvYyAhCqipPoFxqHQmh1WH1kcpwRlKKoMnzkXEvpQfvap1gUkuksNgGmOpurMQ1fjqSYbvhq/RgjsSSmkIGcui0eqOsIZ7/N2fAmQcs=
Message-ID: <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com>
Date: Tue, 19 Dec 2006 12:42:41 -0500
From: "Bob Copeland" <me@bobcopeland.com>
To: "Dave Jones" <davej@redhat.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
In-Reply-To: <20061219164146.GI25461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain>
	 <20061219164146.GI25461@redhat.com>
X-Google-Sender-Auth: 995a35d24294311d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/06, Dave Jones <davej@redhat.com> wrote:
> On Tue, Dec 19, 2006 at 10:46:24AM -0500, Robert P. J. Day wrote:
>  >
>  >   just for fun, i threw the following together to peruse the tree (or
>  > any subdirectory) and look for stuff that violates the CodingStyle
>  > guide.  clearly, it's far from complete and very ad hoc, but it's
>  > amusing.  extra searches happily accepted.
>
> I had a bunch of similar greps that I've recently been half-assedly
> putting together into a single script too.
> See http://www.codemonkey.org.uk/projects/findbugs/

I don't know if anyone cares about them anymore, since I think gcc
grew some smarts in the area recently, but there are a lot of lines of
code matching "static int.*= *0;" and equivalents in the driver tree.

Bob

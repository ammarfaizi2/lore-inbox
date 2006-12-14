Return-Path: <linux-kernel-owner+w=401wt.eu-S932785AbWLNPK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWLNPK7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932792AbWLNPK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:10:59 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:26515 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932785AbWLNPK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:10:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I4Wo57GfB78A0DZUs0aUGFJqCg21qOHkoW3ywWPGGk04nz6w2bdR01pXMYmSSjimAxZYoWJ86Cb4OR8O8ulJpeEE1oqHJFfodCcmMVaz6cwllD9XCTFbM4zjxrOsxQpRD+qqX6kzn+ypbUw9Ml1Yjp7pSSBurLmCM/CNLolnrbs=
Message-ID: <9a8748490612140710o478bf73p7efc607f545cf499@mail.gmail.com>
Date: Thu, 14 Dec 2006 16:10:55 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Manuel Reimer" <Manuel.Spam@nurfuerspam.de>
Subject: Re: Will there be security updates for 2.6.17 kernels?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <elrop2$vdl$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <elrop2$vdl$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/06, Manuel Reimer <Manuel.Spam@nurfuerspam.de> wrote:
> Hello,
>
> my problem is, that the slackware maintainers decided to use kernel
> 2.6.17. Here is their comment, they posted to the changelog:
>
<snip>
>
> They had a 2.6.16 kernel in /extra before and as far as I know the
> 2.6.16 kernel series still gets security updates.
>
> Is this also the case for 2.6.17 kernels?

No, that is not planned. 2.6.16.x is an exception.    -stable kernels
(those with 2.6.x.y versions) are only released for the latest stable
2.6.x kernel. So currently that's 2.6.19 and as soon as 2.6.20 comes
out there will not be any more 2.6.19.x, only 2.6.20.x   - I hope
that's clear...

>will there be an update if
> there is an security hole in the latest 2.6.17 kernel?
>
No. If the problem was also in the latest stable kernel (currently
2.6.19.1) then a fix would go into 2.6.19.2 and users can then upgrade
to that kernel. If 2.6.19.1 is not vulnerable, then everything is fine
as users of old 2.6.17 kernels can just upgrade to 2.6.19.1


> The problem is, that the slackware team doesn't patch anything on their
> own. They always wait for the update done by the author, if the bug
> isn't very critical. This means they will stay forever with their
> current version of the 2.6.17 kernel, if there will be no updates in
> future.
>
Not true. Slackware updates the kernel to fix security issues - this
has been the case in the past and i don't see why it would change in
the future.

> If there will be no updates for 2.6.17 in future: Are there already
> security holes in 2.6.17?

probably.

>Could someone please give two examples? I need
> informations, to be able to contact the slackware team, to request a
> "downgrade" to 2.6.16.
>
Ehh, you wouldn't want to do that. You'd want to encourage an upgrade
to 2.6.19.1 instead.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVJEUvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVJEUvn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVJEUvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:51:43 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:32180 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750832AbVJEUvn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:51:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XvUn+iu3aN6eauslTKLWl0bE4o6F41HcBkprL2eXTE0s+JoreSIO2uv6IIcuNCmCpeo7uIp8F6ajEzDl+q+KXPwo0tu2zRJZRE1sAwhuyi0Sxs1tXVFGWBprYC1X5gQf2HPeflrcFDWz7aQclWnRG/iLuzAySwnck8KuLc2hiFA=
Message-ID: <6880bed30510051351ja5bd5dfo5fbec9514a5cbdd7@mail.gmail.com>
Date: Wed, 5 Oct 2005 22:51:32 +0200
From: Bas Westerbaan <bas.westerbaan@gmail.com>
Reply-To: Bas Westerbaan <bas.westerbaan@gmail.com>
To: Julian Blake Kongslie <jblake@omgwallhack.org>
Subject: Re: what's next for the linux kernel?
Cc: Marc Perkel <marc@perkel.com>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051005134109.757a5e42@kolionychia.omgwallhack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	 <E1EMutG-0001Hd-7U@be1.lrz> <43443723.907@perkel.com>
	 <20051005134109.757a5e42@kolionychia.omgwallhack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can delete a directory entry to a file if you have proper
permission to the directory.

You cannot read or write the file if the file doesn't give you permission to.

A hard link makes an additional directory entry to a certain file. You
delete the directory entry to the file, not the file.

And permissions are the same for all instances of the file.

My 2 cents.

On 10/5/05, Julian Blake Kongslie <jblake@omgwallhack.org> wrote:
> On Wed, 05 Oct 2005 13:27:15 -0700
> Marc Perkel <marc@perkel.com> wrote:
> > There would be different rights to eack link.
>
> Well, color me confused.
>
> You appear to be saying that the permission on a file differ depending
> on which link you are accessing it by. Furthermore, your stance seems to
> imply that linking to a file grants either write permission or ownership
> on the new link.
>
> So, under this permission model, I could link to /etc/passwd in my
> home directory, edit the link to change my UID to zero, then relogin to
> the system as an administrator.
>
> Not that I would need to, of course, because any user who owns/could
> write to a directory would be able to alter any file on the entire
> system. I know they're called "permission" models, but that seems
> *extremely* permissive...
>
> --
> -Julian Blake Kongslie
> <jblake@omgwallhack.org>
>
>
>



--
Bas Westerbaan
http://blog.w-nz.com/
GPG Public Keys: http://w-nz.com/keys/bas.westerbaan.asc

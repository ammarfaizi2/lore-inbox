Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVK0BvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVK0BvO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 20:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVK0BvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 20:51:14 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:38106 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750797AbVK0BvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 20:51:14 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Date: Sun, 27 Nov 2005 01:51:21 +0000
User-Agent: KMail/1.9
Cc: David Brown <dmlb2000@gmail.com>, linux-kernel@vger.kernel.org
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <200511270138.25769.s0348365@sms.ed.ac.uk> <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
In-Reply-To: <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511270151.21632.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 November 2005 01:46, Nish Aravamudan wrote:
[snip]
> >
> > Sure enough, I can confirm this.
> >
> > I don't seem to have to provide --no-same-permissions to tar to get umask
> > to affect the permissions of extracted files, so my files are fine
> > on-disc.
>
> FWIW, ubuntu's man-pages claim:
>
> "       --no-same-permissions
>               apply umask to extracted files (the default for non-root
> users)"
>
> and
>
> "       -p, --same-permissions, --preserve-permissions
>               ignore umask when extracting files (the default for root)"
>
> Maybe you are untarring as non-root and David is untarring as root?
>

Thanks Nish, this is obviously the difference. I never compile anything as 
root (pesky Makefiles rm -rf'ing things!).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

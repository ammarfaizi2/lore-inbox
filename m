Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWEGW7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWEGW7J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 18:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWEGW7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 18:59:09 -0400
Received: from wx-out-0102.google.com ([66.249.82.199]:9673 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750774AbWEGW7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 18:59:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dVonJuA/5YNac+JMcHK06cJsF36PEbE/kf98QN6MJDlWkQkXRn6ey68dR7Pn54PC3R6vktf3F1o2jwr15U+B2FtgPt6SQjHcX8f/J0btQKIiQxuHWYsKidLsVltCYLQpwwfIRLQnfrNOZm4WID0/lTOiwQ03DpZLI8Je+cqTukA=
Message-ID: <b8bf37780605071559p6daa6988ue5b1ee668ce62e08@mail.gmail.com>
Date: Sun, 7 May 2006 19:59:08 -0300
From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: XFS regression on 2.6.17 (Does not happen on 2.6.16.XX)
Cc: linux-kernel@vger.kernel.org, dgc@sgi.com, chrisw@sous-sol.org
In-Reply-To: <20060507224606.GA1224@frodo>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <b8bf37780605071536j67ff4152r7f664e438a9a96b8@mail.gmail.com>
	 <20060507224606.GA1224@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/06, Nathan Scott <nathans@sgi.com> wrote:
> On Sun, May 07, 2006 at 07:36:50PM -0300, Andr? Goddard Rosa wrote:
> > Hi, XFS maintainers!
>
> Hi there,
>
> > I got an error when booting 2.6.17-rc3-git13 (I have this same error
> > since 2.6.17) that prevents be from booting normally.
> >
> > This never happened before until 2.6.17 and is reproducible. I already
> > run xfs_check and xfs_repair but they did nothing.
>
> This is likely to be related to write barriers.  I sent a barrier fix
> which is probably going to resolve this on last week (I say "probably"
> as this is not exactly the same symptoms as before), but looks like
> its not yet merged, I'll resend today.
>
> > What data do you need to help me on this issue?
>
> (/me squints -- did you take that photo in a dark room? :)

DuP! Yes, now it is dark here, I can do better next time! :)

> Can you try the current -mm tree to make sure the problem is fixed
> there already?

Yes, I do not have this problem in -mm.

Thanks you so much for the quick response!
--
[]s,
André Goddard

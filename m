Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278263AbRJSBTV>; Thu, 18 Oct 2001 21:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278267AbRJSBTM>; Thu, 18 Oct 2001 21:19:12 -0400
Received: from [209.195.52.30] ([209.195.52.30]:45325 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S278266AbRJSBSw>;
	Thu, 18 Oct 2001 21:18:52 -0400
Date: Thu, 18 Oct 2001 16:57:48 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: John Alvord <jalvo@mbay.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <9ttustkpmhc24c6q53bv5jghl3g257htdp@4ax.com>
Message-ID: <Pine.LNX.4.40.0110181655340.1380-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so are you saying that BSD licened modules are not going to be allowed to
use any future entry points (assuming they are all put under the the
export_symbol_gpl limits)?

saying that existing stuff will not change doesn't answer the problem
about licences that may have source avilable (tainting) but may not. if
you assume either way you will cause a bunch of problems.

David Lang

 On Thu, 18 Oct 2001, John Alvord wrote:

> Date: Thu, 18 Oct 2001 17:46:18 -0700
> From: John Alvord <jalvo@mbay.net>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
>
> On Thu, 18 Oct 2001 15:38:36 -0700 (PDT), David Lang
> <david.lang@digitalinsight.com> wrote:
>
> >so what will the export_symbol_gpl stuff do with the BSD license? it may
> >or may not have source avilable so is it allowed to use the exported
> >symbols or not?
> >
> >for the tainting module process there is the same problem.
> >
> >knowing the license the code was released under does not tell you if the
> >source is available or not.
> Linus said that all existing entry points would remain untagged. Thus
> existing modules would not be affected.
>
> john
>

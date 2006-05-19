Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWESWvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWESWvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 18:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWESWvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 18:51:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:50243 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751416AbWESWvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 18:51:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VMXLRFQw77aYUP6pAvBpW4E6dtGJMaDaP0W0YTvYe6a2I1eHs/H6cZ5R4ddHGi9bxPV9YSBLv3rD7mUePTS38Bstmsv10EdZ/Og8FcIPA2twEJsYY4sfiCW1nzCJKdMlDrKLtxcghiThGeEfqB9uLMDuKo/dWurLQM0ZX0LHt+4=
Message-ID: <7e90c9180605191551n7193e597s552db3d67e76128b@mail.gmail.com>
Date: Fri, 19 May 2006 15:51:37 -0700
From: "Peter Gordon" <codergeek42@gmail.com>
To: "linux cbon" <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060519220949.41083.qmail@web26605.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1148051890.26628.138.camel@capoeira>
	 <20060519220949.41083.qmail@web26605.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/06, linux cbon <linuxcbon@yahoo.fr> wrote:
> Are "DRIs" the best available open-source drivers for
> old ATI cards ?
Yes.

> Done by reverse engineering ?
Nope. As I understand it, the R200 drivers and earlier are written
from actual specs submitted to the X.org/Mesa/DRI hackers by ATi
(under some NDAs).
The R300/R400 stuff is being reverse-engineered.

> And not all functions are usable :-(.
Most of it is there: hardware video scaling (XVideo), OpenGL hardware
acceleration where available, DDC/I2C support, MergedFB/Xinerama
(multi-head setups), Render acceleration (yay for EXA!) etc. The only
major thing that isn't to my knowledge is the S3TC texture compression
(due to patents?).

> What about newer ATI or Nvidia cards ? A hope for
> something better ?
Intel's published specs and open source drivers for their integrated
video chips (which can do cool things like XvMC, etc.). From speaking
with a couple of X.org hackers, the GMA 900/950 stuff is supposed to
have nearly equivalent performance to a Radeon 9500 or so. (Thanks,
Intel!)

> By the way : did you know of this project about an
> "open source graphic card" ?
> Hardware specs are open, so no need of [NDA] and
> open-source drivers coding easier :
> http://opengraphics.gitk.com/open_graphics_spec.pdf
> http://lists.duskglow.com/mailman/listinfo/open-graphics
> (still a project).
I'm hoping to be able to buy one Real Soon Now(TM). :)

--Peter

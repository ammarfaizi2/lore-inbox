Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTHXD5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 23:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTHXD5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 23:57:53 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:17068
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S264605AbTHXD5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 23:57:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <lista1@comhem.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18.1int
Date: Sun, 24 Aug 2003 14:04:17 +1000
User-Agent: KMail/1.5.3
References: <20030824000324.559cb9db.lista1@comhem.se>
In-Reply-To: <20030824000324.559cb9db.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308241404.17945.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003 08:03, Voluspa wrote:
> On 2003-08-23 12:21:14 Con Kolivas wrote:
> > On Sat, 23 Aug 2003 19:08, Thomas Schlichter wrote:
> >> On Saturday 23 August 2003 07:55, Con Kolivas wrote:
>
> [...]
>
> >> First of all... Your interactive scheduler work is GREAT! I really
> >> like it...!
>
> [...]
>
> > P.S. All this may be moot as it looks like I, or someone else, may
> > have to start again.
>
> If you do, please remember this report. Quick summary: All problem areas
> I've seen are completely resolved - or at least to a major extent.
> Blender, wine and "cp -a".
>
> Andrew Mortons red flag was a good incentive to run my tests on a
> pure 2.6.0-test4 and write down the outcome. Adding the O18.1int after
> this really stand out.

Thanks for extensive testing and report.

I didn't want to make a fuss about these O18 patches because I've been excited 
by changes previously that weren't as good as I first thought. 

My mistake after O15 was that my patches made priority inversion (always 
there) much much worse at times, and I went looking for a generic solution to 
priority inversion which has destroyed better coders than I. Instead I went 
looking for why it was much worse on O15+ and found two algorithm bugs. Much 
better to kill off bugs than hide them under the carpet. 

Furthermore it doesn't look like it's my fault for the drop in performance on 
big SMP after all which is good news.

Con


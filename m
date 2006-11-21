Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755946AbWKUWR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbWKUWR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbWKUWR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:17:28 -0500
Received: from nz-out-0102.google.com ([64.233.162.196]:50913 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1755216AbWKUWR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:17:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kH/ilvRJcYiLGUEstxwch9Pdm5dbFHyi2kQYaA0VTu+3BbgftVH/e88exjXR9ZU8hdh0EKHygEyaMOemQrkyhZWHPDqiaRFtTSli3eq8/ySGK+lvyO96Z2RpdzJNl7CA3k5UvfuPghRV11zTDdiL7XOHVSHfTnemFVO1Gk2+9wA=
Message-ID: <c673fbfa0611211417v732f2c0ao2d73f8bf12608768@mail.gmail.com>
Date: Tue, 21 Nov 2006 14:17:26 -0800
From: "Davor Cubranic" <cubranic@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Freeze with ATI Xpress 200
In-Reply-To: <c673fbfa0610301216o628ea862jf29fab64a4ba543@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c673fbfa0610301216o628ea862jf29fab64a4ba543@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to follow up on my original report: This seems to be a problem
with running AMD "Cool & Quiet" when using the on-board graphics. (Why
would Shuttle design an AMD motherboard with a integrated graphics
which crashes the system if C&Q is turned on? Good question. Shame on
Shuttle.) I initially reported that Windows worked fine, but although
I did have AMD CPU driver installed on Windows, C&Q wasn't turned on
in the "power options" control settings. Once I did that, Windows
started crashing with the same symptoms as well until I turned it off
again. I then turned off powernowd in Ubuntu and haven't seen it crash
since. I'm guessing I never saw this in Gentoo because it did not have
powernowd activated by default.

At any rate, this is not a kernel issue, sorry for the trouble.

Davor

P.S. I am not on this list, so please email me directly with any
comments or questions.

On 10/30/06, Davor Cubranic <cubranic@gmail.com> wrote:
> I am experiencing occasional system freezes in Ubuntu 6.06 (Dapper) on
> a Shuttle ST20G5 with an Athlon (Venice) CPU and ATI Xpress 200
> chipset. It happens in X only -- the entire screen goes white and the
> computer does not respond any more to anything but power-cycle. I had
> the same issue in Breezy, then switched to Gentoo 2006.0 where
> everything worked fine, and now that I'm back to Ubuntu with Dapper, I
> see the issue is still there. It usually happens within an hour,
> especially once I start up Firefox and/or Thunderbird. There are no
> messages on the screen (at least those that are visible in X) or
> kernel logs, the kernel crashes that hard.
>
> I've had this happen with open-source Radeon driver on Dapper and
> ATI's fglrx drivers and the generic VESA on Breezy, so it doesn't look
> like the problem is in the graphics driver. As I already mentioned,
> this did not happen on Gentoo (both 2.6.15 and 2.6.16 kernels) nor on
> Windows XP sp2 (dual-boot), and I haven't found any memory errors
> using memtest. I would be happy to do any further investigation that
> would help in narrowing down the problem, but am at a loss at where to
> even start, so I'll submit my system's details here and I hope someone
> can tell me if there is anything I can do to either narrow down the
> source of the problem or capture more details about the crash.
>
> Davor
>
>
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbTCTUKJ>; Thu, 20 Mar 2003 15:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbTCTUKJ>; Thu, 20 Mar 2003 15:10:09 -0500
Received: from buug.mind.de ([212.42.230.8]:30380 "EHLO mail.buug.de")
	by vger.kernel.org with ESMTP id <S261928AbTCTUKI>;
	Thu, 20 Mar 2003 15:10:08 -0500
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Release of 2.4.21
Mail-Followup-To: linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
From: krause@sdbk.de (Sebastian D.B. Krause)
Date: Thu, 20 Mar 2003 21:21:01 +0100
In-Reply-To: <20030320195657.GA3270@drcomp.erfurt.thur.de> (Adrian Knoth's
 message of "Thu, 20 Mar 2003 20:56:57 +0100")
Message-ID: <874r5xyeky.fsf@sdbk.de>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <20030320195657.GA3270@drcomp.erfurt.thur.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3487 September 1993, Adrian Knoth wrote:
> how about releasing 2.4.21 with the ptrace()-fix applied immediately
> like it has been done with 2.2.25?
>
> I think it's a serious bug and therefore it's time for a security-update.

I think the best way is to release a 2.4.21 kernel with only the
most important fixes (e.g. ptrace, ext3) and no new features. All
new featues which need more testing and are now in 2.4.21-pre could
then go to 2.4.22-pre for more testing (as Alan did with
2.2.25-pre1). This would be a way to react to important bugs very
fast without a lack of enough testing which is just impossible with
the current release scheme. It's just too dangerous to call 2.4.20
"stable" and wait another few month for 2.4.21.

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSBONiR>; Fri, 15 Feb 2002 08:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289571AbSBONiH>; Fri, 15 Feb 2002 08:38:07 -0500
Received: from zero.tech9.net ([209.61.188.187]:53003 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289564AbSBONiB>;
	Fri, 15 Feb 2002 08:38:01 -0500
Subject: Re: oops with 2.4.18-pre9-mjc2
From: Robert Love <rml@tech9.net>
To: Robert Jameson <rj@open-net.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org>
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 15 Feb 2002 08:37:52 -0500
Message-Id: <1013780277.950.663.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-15 at 03:51, Robert Jameson wrote:
> I have been seeing this oops from 2.4.16 -> 2.4.18-pre9, so here we go!

Do you see this on device close?  It looks like there may be a race
between device closer -> usb release.

Can you reproduce it without the binary module you are loading?

	Robert Love


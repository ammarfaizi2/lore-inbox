Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSFRQLi>; Tue, 18 Jun 2002 12:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSFRQLi>; Tue, 18 Jun 2002 12:11:38 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:47112 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S317472AbSFRQLg>;
	Tue, 18 Jun 2002 12:11:36 -0400
Date: Tue, 18 Jun 2002 09:11:37 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binary compatibity (mixing different gcc versions) in modules
Message-ID: <20020618091137.A9730@ecam.san.rr.com>
References: <7w3cvmdquu.fsf@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <7w3cvmdquu.fsf@avalon.france.sdesigns.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 02:36:25PM +0200, Emmanuel Michon wrote:
> Hi,
> 
> looking at nvidia proprietary driver, the makefile warns
> the user against insmod'ing a module compiled with a gcc
> version different from the one that was used to compile
> the kernel.
> 
> This sounds strange to me, since I never encountered this
> problem.

Really strange since most of the NVidia driver is binary already.
So another question would be if their binary part is compiled with
the same compiler as you have.

So as most of the other people said it probably doesn't matter but
there is a good chance NVidia is already forcing you to break their
own advice.

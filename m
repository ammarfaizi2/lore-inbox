Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265664AbSJXV3y>; Thu, 24 Oct 2002 17:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265666AbSJXV3y>; Thu, 24 Oct 2002 17:29:54 -0400
Received: from tapu.f00f.org ([66.60.186.129]:45987 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S265664AbSJXV3x>;
	Thu, 24 Oct 2002 17:29:53 -0400
Date: Thu, 24 Oct 2002 14:36:06 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ashwin Sawant <sawant_ashwin@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Workqueues and the Nvidia driver
Message-ID: <20021024213606.GB18547@tapu.f00f.org>
References: <20021023175255.547.qmail@webmail30.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023175255.547.qmail@webmail30.rediffmail.com>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 05:52:55PM -0000, Ashwin  Sawant wrote:

> I have successfully compiled the latest Nvidia driver with kernel
> 2.5.44 on a heavily modified RH 7.2 (original compiler) box after
> applying the patch posted to this list previously.

I wrote the initial workqueues patch --- and it was bogus of me to use
workqueues.

I have a patch that uses tasklet instead which works much better; if
you want this email me off the list (this applies to anyone who wants
this stuff --- DO NOT clutter l-k with this please).



  --cw

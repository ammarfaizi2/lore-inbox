Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268452AbUILFHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbUILFHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268453AbUILFHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:07:20 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:42639 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268452AbUILFGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:06:08 -0400
Date: Sat, 11 Sep 2004 22:06:02 -0700
From: Chris Wedgwood <cw@f00f.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] Kill CONFIG_4KSTACKS
Message-ID: <20040912050602.GA30451@taniwha.stupidest.org>
References: <20040911204125.GA26179@taniwha.stupidest.org> <20040912050030.GD2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912050030.GD2660@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 10:00:30PM -0700, William Lee Irwin III wrote:

> Another, distinct patch to add warnings or errors for all versions
> of gcc prior to the stack fix commit might be helpful.

It's only for comments right now, but sure yes.  And if we are going
to do that we should drop support for ancient gcc versions[1] and fix
up some 'sections' presently used (I thought we had some hacks in
there now for gcc-2.95, I should recheck).


 --cw

[1] it used to be sparc64 was a problem when this was discussed
    before, is that still the case?

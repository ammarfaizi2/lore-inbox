Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTEOQqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 12:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTEOQqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 12:46:22 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:54503 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S264110AbTEOQox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 12:44:53 -0400
Date: Thu, 15 May 2003 18:47:38 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Christopher Hoover <ch@murgatroid.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
Message-ID: <20030515184738.C626@nightmaster.csn.tu-chemnitz.de>
References: <20030513213157.A1063@heavens.murgatroid.com> <20030514071446.A2647@infradead.org> <20030514005213.A3325@heavens.murgatroid.com> <3EC296CE.9050704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3EC296CE.9050704@redhat.com>; from drepper@redhat.com on Wed, May 14, 2003 at 12:19:42PM -0700
X-Spam-Score: -4.5 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19GM34-0006BK-00*eVIy2TRqIAk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 14, 2003 at 12:19:42PM -0700, Ulrich Drepper wrote:
[CONFIG_FUTEX]
> If this is what is wanted (and I don't really think it's useful is a MMU
> is available) you should explain the consequences in the help text.
> Basically, no current and future glibc version has the slightest chance
> of working.

Is this also the case, if I don't want threading at all on my
system? Does glibc still have a seperate static library for this,
or should I revert to dietlibc in these cases?

Thanks & Regards

Ingo Oeser

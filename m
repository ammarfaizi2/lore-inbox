Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVIRKgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVIRKgG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVIRKgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:36:05 -0400
Received: from khc.piap.pl ([195.187.100.11]:8196 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751077AbVIRKgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:36:04 -0400
To: "Martin Fouts" <Martin.Fouts@palmsource.com>
Cc: <jesper.juhl@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Why don't we separate menuconfig from the kernel?
References: <DE88BDF02F4319469812588C7950A97E93121E@ussunex1.palmsource.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Sep 2005 12:36:03 +0200
In-Reply-To: <DE88BDF02F4319469812588C7950A97E93121E@ussunex1.palmsource.com>
Message-ID: <m3zmqaek8c.fsf@defiant.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Fouts" <Martin.Fouts@palmsource.com> writes:

> I don't have a patch yet, but I've just spent a bit of time looking at
> how kbuild works, and I believe there is a fairly straightforward way to
> keep kbuild in the kernel tree but make it easy to split it out so that
> someone could use it as a separate tool.

That is obvious and people already are doing that, what I'm thinking of is
moving menuconfig or *config out of the kernel so there is one well-defined
external package.
-- 
Krzysztof Halasa

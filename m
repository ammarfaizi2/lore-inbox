Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVFVOq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVFVOq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFVOov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:44:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:12467 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261321AbVFVOmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:42:33 -0400
Date: Wed, 22 Jun 2005 16:42:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: kbuild-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Fix signed char problem in scripts/basic
In-Reply-To: <42B92923.6080100@drzeus.cx>
Message-ID: <Pine.LNX.4.61.0506221640290.3728@scrub.home>
References: <42B92923.6080100@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 22 Jun 2005, Pierre Ossman wrote:

> -void define_config(const char * name, int len)
> +void define_config(const void * name, int len)

Could you try to drop the remaining "signed" instead of this?

bye, Roman


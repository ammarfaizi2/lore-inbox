Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVJFKhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVJFKhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVJFKhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:37:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35206 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750796AbVJFKhE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:37:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051006044015.GA31458@beast> 
References: <20051006044015.GA31458@beast> 
To: David McCullough <davidm@snapgear.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, dhowells@redhat.com
Subject: Re: [PATCH] 2.6.13 - output of /proc/maps on nommu systems is incomplete 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 06 Oct 2005 11:36:52 +0100
Message-ID: <22952.1128595012@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David McCullough <davidm@snapgear.com> wrote:

> Simple patch against 2.6.13 for /proc/maps on nommu systems.
> Currently you do not get all the map entries because the start
> function doesn't index into the list using the value of "pos".

Looks reasonable.

Signed-Off-By: David Howells <dhowells@redhat.com>

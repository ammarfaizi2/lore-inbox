Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVBZXpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVBZXpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBZXpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:45:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:56777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261298AbVBZXpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:45:36 -0500
Date: Sat, 26 Feb 2005 15:45:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthias.Kunze@gmx-topmail.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config option for default loglevel
Message-Id: <20050226154505.43889139.akpm@osdl.org>
In-Reply-To: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de>
References: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Kunze <Matthias.Kunze@gmx-topmail.de> wrote:
>
> I've created a little patch to make the default loglevel a configurable
>  option.

It'd be better to make it a kernel boot option, IMO.  We already have
`debug' and `quiet' (init/main.c), which are rather silly things.  An
option to set the initial loglevel would make sense.

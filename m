Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbUJYMzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUJYMzh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUJYMzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:55:37 -0400
Received: from sd291.sivit.org ([194.146.225.122]:1723 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261789AbUJYMzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:55:18 -0400
Date: Mon, 25 Oct 2004 14:56:30 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041025125629.GF6027@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410210154.58301.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 01:54:58AM -0500, Dmitry Torokhov wrote:

> I have been looking at the sysdevs in present in the kernel and noticed that
> sonypi was registering itself as a system device. Surely it is possible to
> suspend it with interrupyts enabled, so it better be converted to a platform
> device. I course of convert I also did some additional changes:
[...]

Thanks for those patches and sorry for the lack of response, I was out
of town for the last week.

I have quite a few changes in my tree already for the sonypi driver,
and I was delaying the submission because I need to solve a problem
with the integration with the input subsystem...

Some of your changes (those related to module_param(), wait_event()
use etc) were already in my tree, those related to whitespace cleanup,
platform instead of sysdev etc are new and I will integrate them.

Let me work a bit on those, and I will try to separate my changes
and resubmit them in the next days.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    

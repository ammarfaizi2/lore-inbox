Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbULRTjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbULRTjl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 14:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbULRTjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 14:39:41 -0500
Received: from users.ccur.com ([208.248.32.211]:57454 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261218AbULRTjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 14:39:40 -0500
Date: Sat, 18 Dec 2004 14:39:39 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Joseph Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does atomic_read actually do?
Message-ID: <20041218193939.GA23080@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <opsi7o5nqfs29e3l@grunion> <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsi7xcuizs29e3l@grunion>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 02:20:44PM -0500, Joseph Seigh wrote:
> so why use atomic_read?

Because atomic_t is opaque and atomic_read lets you get at
the value when that is all you want to do.

Regards,
Joe

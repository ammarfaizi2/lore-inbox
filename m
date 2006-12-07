Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031772AbWLGHWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031772AbWLGHWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 02:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031774AbWLGHWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 02:22:43 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44800
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1031772AbWLGHWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 02:22:42 -0500
Date: Wed, 06 Dec 2006 23:22:53 -0800 (PST)
Message-Id: <20061206.232253.28806606.davem@davemloft.net>
To: mattjreimer@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: D-cache aliasing issue in cow_user_page
From: David Miller <davem@davemloft.net>
In-Reply-To: <f383264b0612062220j283f0ad6u5be9db6ac79dbbe9@mail.gmail.com>
References: <f383264b0612061319k16809e35tb04d04fa16f976b1@mail.gmail.com>
	<20061206.164616.74731030.davem@davemloft.net>
	<f383264b0612062220j283f0ad6u5be9db6ac79dbbe9@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matt Reimer" <mattjreimer@gmail.com>
Date: Wed, 6 Dec 2006 22:20:22 -0800

> Ok, good to know, since that's what we're doing with ARM drivers
> presently. What's the preferred method going forward?

There are multiple ways provided to solve the problem so that
platforms can use whichever variant works best.

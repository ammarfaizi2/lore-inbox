Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbVIMOUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbVIMOUH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVIMOUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:20:07 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:43160 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S964791AbVIMOUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:20:06 -0400
Date: Tue, 13 Sep 2005 16:20:03 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: HZ question
In-Reply-To: <4326DB8A.7040109@compro.net>
Message-ID: <Pine.LNX.4.53.0509131615160.13574@gockel.physik3.uni-rostock.de>
References: <4326CAB3.6020109@compro.net> <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
 <4326DB8A.7040109@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Mark Hounschell wrote:

> Most if not all userland delay calls rely on HZ value in some way or
> another. The minimum reliable delay you can get is one (kernel)HZ. A
> program that needs an acurrate delay for a time shorter that one
> (kernel)HZ may have an alternative if it knows that HZ is greater the
> the requested delay.

Just assume that kernel HZ are USER_HZ and see anything else as an
additional bonus that you cannot rely on.

What does 'acurrate delay' mean, anyways?

Tim

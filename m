Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280793AbRKBS4R>; Fri, 2 Nov 2001 13:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280788AbRKBSyg>; Fri, 2 Nov 2001 13:54:36 -0500
Received: from [200.43.19.130] ([200.43.19.130]:19464 "EHLO altavista.net")
	by vger.kernel.org with ESMTP id <S280781AbRKBSxD>;
	Fri, 2 Nov 2001 13:53:03 -0500
Date: Fri, 2 Nov 2001 15:52:52 -0300
From: Alberto Bertogli <albertogli@altavista.net>
To: gspujar@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: software watchdog
Message-ID: <20011102155252.A284@altavista.net>
Mail-Followup-To: Alberto Bertogli <albertogli@altavista.net>,
	gspujar@hss.hns.com, linux-kernel@vger.kernel.org
In-Reply-To: <65256AF8.00218CB4.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <65256AF8.00218CB4.00@sandesh.hss.hns.com>; from gspujar@hss.hns.com on Fri, Nov 02, 2001 at 11:38:47AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 11:38:47AM +0530, gspujar@hss.hns.com wrote:
> Hi,
> I am using software watchdog in my application. Is there any way to ensure that
> watchdog continues its
> job even after the process that opens the watchdog device crashes or teminates ?
> 

I think CONFIG_WATCHDOG_NOWAYOUT is exactly what you want.
You find it just where you enabled your watchdog.

		Alberto


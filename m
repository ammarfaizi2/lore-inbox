Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbRAQAjf>; Tue, 16 Jan 2001 19:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130007AbRAQAjZ>; Tue, 16 Jan 2001 19:39:25 -0500
Received: from tetsuo.zabbo.net ([204.138.55.44]:5901 "HELO tetsuo.zabbo.net")
	by vger.kernel.org with SMTP id <S129962AbRAQAjQ>;
	Tue, 16 Jan 2001 19:39:16 -0500
Date: Tue, 16 Jan 2001 19:39:11 -0500
From: Zach Brown <zab@zabbo.net>
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] maestro3 oops + fix (for ac9!)
Message-ID: <20010116193911.J1746@tetsuo.zabbo.net>
In-Reply-To: <20010116112925.A1941@incandescent.mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010116112925.A1941@incandescent.mp3revolution.net>; from dilinger@mp3revolution.net on Tue, Jan 16, 2001 at 11:29:25AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> D'oh, looks like if power management is disabled, pmdev is NULL (I get
> that message when I load the module), but we try to derefence it anyways.
> The fix is obvious:

duh, yeah, I'll send out a proper patch that handles the pm_register
failure too.

thanks.

-- 
 zach
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

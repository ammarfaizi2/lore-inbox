Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSHOKkX>; Thu, 15 Aug 2002 06:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSHOKkX>; Thu, 15 Aug 2002 06:40:23 -0400
Received: from dsl-213-023-043-164.arcor-ip.net ([213.23.43.164]:59331 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316684AbSHOKkW>;
	Thu, 15 Aug 2002 06:40:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Stas Sergeev <stssppnn@yahoo.com>, Andrew Rodland <arodland@noln.com>
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Date: Thu, 15 Aug 2002 12:46:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <3D5AE7BB.5040005@yahoo.com>
In-Reply-To: <3D5AE7BB.5040005@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17fI8y-0002az-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 August 2002 01:28, Stas Sergeev wrote:
> Also try disabling APM manually. If this doesn't
> help then this is another problem but anyway someone is
> disabling interrups for the large periods, (hopefully)
> only this can cause such an effect.

And if that's the case, he's broken for a lot more reasons than the
speaker sound driver.  We've just discovered a new use for this
driver: detecting interrupt-disable borkness that needs to be hunted
down and killed.

-- 
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310740AbSCHIwt>; Fri, 8 Mar 2002 03:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310741AbSCHIwj>; Fri, 8 Mar 2002 03:52:39 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:43484 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S310740AbSCHIwV>;
	Fri, 8 Mar 2002 03:52:21 -0500
Date: Fri, 8 Mar 2002 08:50:28 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Message-ID: <20020308085028.A14375@fenrus.demon.nl>
In-Reply-To: <200203080823.g288NC514338@fenrus.demon.nl> <3C8877D7.2020708@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C8877D7.2020708@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Mar 08, 2002 at 09:35:35AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 09:35:35AM +0100, Martin Dalecki wrote:
> Please look closer at my posting. I just think, that since there
> are apparently no tru hardware raid devices out there it would
> be sufficient to expand the detection code to not ignore
> RAID class devices at all. This would just prevent
> us from having two different entries in the
> device detection list. Not much more involved I think.

There's one tiny glitch: there are exactly 2 "real" raid devices out there
(that I know of at least). But anyway, a "don't look at" list will be
MUCH shorter than a "look also at" list.


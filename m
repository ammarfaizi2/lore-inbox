Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292021AbSBAU4O>; Fri, 1 Feb 2002 15:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292019AbSBAU4B>; Fri, 1 Feb 2002 15:56:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47527 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S292001AbSBAUyy>;
	Fri, 1 Feb 2002 15:54:54 -0500
Date: Fri, 1 Feb 2002 15:54:51 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Monta <pmonta@pmonta.com>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201155451.A4843@havoc.gtf.org>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <20020201153346.B2497@havoc.gtf.org> <3C5AFD4B.4010803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5AFD4B.4010803@zytor.com>; from hpa@zytor.com on Fri, Feb 01, 2002 at 12:40:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:40:43PM -0800, H. Peter Anvin wrote:
> Jeff Garzik wrote:
> > Even if you think you have a good true source of random noise, you need
> > to run good fitness tests on the data to ensure it's truly random.

> The i810 user-space code already should do this, though, right?  Could one
> simply point the existing rngd at /dev/dsp instead?

Theoretically yes.  rngd is tuned right now for i810's byte-at-a-time
device, but it would be simple to make the code more generic, or simply
use a faster device in a slower byte-at-a-time mode.

	Jeff




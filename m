Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291994AbSBAUlY>; Fri, 1 Feb 2002 15:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291988AbSBAUlO>; Fri, 1 Feb 2002 15:41:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41220 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291989AbSBAUlD>; Fri, 1 Feb 2002 15:41:03 -0500
Message-ID: <3C5AFD4B.4010803@zytor.com>
Date: Fri, 01 Feb 2002 12:40:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jeff Garzik <garzik@havoc.gtf.org>
CC: Peter Monta <pmonta@pmonta.com>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <20020201153346.B2497@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> 
> Even if you think you have a good true source of random noise, you need
> to run good fitness tests on the data to ensure it's truly random.
> 


The i810 user-space code already should do this, though, right?  Could one
simply point the existing rngd at /dev/dsp instead?

	-hpa



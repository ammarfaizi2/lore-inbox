Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVL1UKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVL1UKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 15:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVL1UKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 15:10:20 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:33511 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S964897AbVL1UKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 15:10:18 -0500
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ricardo Cerqueira <v4l@cerqueira.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20051228210257.16c7a647.khali@linux-fr.org>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	 <1135726855.6709.4.camel@localhost>
	 <20051228210257.16c7a647.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 28 Dec 2005 18:10:07 -0200
Message-Id: <1135800607.16130.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2005-12-28 às 21:02 +0100, Jean Delvare escreveu:
> Hi Mauro, Linus,

> Looks good to me, except for the coding style. Also, depending on both
> SND and SOUND doesn't make much sense, as SND itself already depends on
> SOUND, so we can simplify the SAA7134_ALSA dependency list.
> 
> Linus, can you please apply this patch before releasing 2.6.15?
> 
> Thanks.
> 
> Fix the cyclic dependency issue between CONFIG_SAA7134_ALSA and
> CONFIG_SAA7134_OSS (credits to Mauro Carvalho Chehab.)
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>


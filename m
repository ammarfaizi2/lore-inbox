Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289278AbSAIJGv>; Wed, 9 Jan 2002 04:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289282AbSAIJGc>; Wed, 9 Jan 2002 04:06:32 -0500
Received: from sj1-3-1-20.securesites.net ([192.220.127.117]:2828 "EHLO
	sj1-3-1-20.securesites.net") by vger.kernel.org with ESMTP
	id <S289279AbSAIJG2>; Wed, 9 Jan 2002 04:06:28 -0500
Date: Wed, 9 Jan 2002 09:06:28 +0000
From: Nathan Myers <ncm-nospam@cantrip.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, deischen@iworks.InterWorks.org
Subject: bad patch in aic7xxx_linux.c
Message-ID: <20020109090628.A18526@cantrip.org>
Mail-Followup-To: Nathan Myers <ncm-nospam@cantrip.org>,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
	deischen@iworks.InterWorks.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

In patch-2.4.17-pre2, a nonsensical change was made in 
linux/drivers/scsi/aic7xxx/aic7xxx_linux.c .  While apparently 
harmless, it suggests to me that you had intended to fold in an 
entirely different patch, and "missed".

I don't find a current maintainer for aic7xxx listed in MAINTAINERS.

Nathan Myers
ncm at cantrip dot org

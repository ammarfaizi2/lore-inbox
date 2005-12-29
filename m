Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVL2UCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVL2UCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVL2UCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:02:17 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:23467 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750919AbVL2UCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:02:16 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Date: Thu, 29 Dec 2005 21:00:23 +0100
User-Agent: KMail/1.8.2
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
References: <20051227215351.3d581b13.khali@linux-fr.org> <1135726855.6709.4.camel@localhost> <20051228210257.16c7a647.khali@linux-fr.org>
In-Reply-To: <20051228210257.16c7a647.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512292100.27536.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 28 December 2005 21:02, Jean Delvare wrote:

> +	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || 
(VIDEO_SAA7134_ALSA=m && m))

Please do it a little less uglier, simply "!VIDEO_SAA7134_ALSA" is enough.

bye, Roman

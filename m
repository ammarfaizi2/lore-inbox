Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTJIPFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbTJIPFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:05:11 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:34452 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262253AbTJIPFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:05:08 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 9 Oct 2003 17:16:51 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling static
Message-ID: <20031009151651.GA20601@bytesex.org>
References: <1065708534.737.2.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065708534.737.2.camel@chevrolet.hybel>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/built-in.o(.text+0x89a60): In function `saa7134_initdev':
> : undefined reference to `register_sound_dsp'

Missing depend on SOUND

  Gerd

-- 
You have a new virus in /var/mail/kraxel

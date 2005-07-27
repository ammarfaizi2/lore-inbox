Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVG0Hzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVG0Hzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 03:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVG0Hzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 03:55:42 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17133 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262044AbVG0Hy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 03:54:28 -0400
Date: Wed, 27 Jul 2005 09:54:23 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vikas <vikas.g@ap.sony.com>
cc: Michael Berger <mikeb1@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: Why this is not working ....
In-Reply-To: <GOEALLDEHIHLBCJFMCOOAEMBCBAA.vikas.g@ap.sony.com>
Message-ID: <Pine.LNX.4.61.0507270952400.30941@yvahk01.tjqt.qr>
References: <GOEALLDEHIHLBCJFMCOOAEMBCBAA.vikas.g@ap.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>PATH=' \ /home\ / $2 \ / $3 \ / lib '
>Why $2 and $3 are not replaced by user passed argument

Because it is in single quotes, and single quotes do not provide 
interpolation^1.


^1 The term used by by perlop(1), section "Quote and Quote-like Operators". 
Interpolation yes/no holds true for bash, too.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137089AbREKJsW>; Fri, 11 May 2001 05:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137090AbREKJsM>; Fri, 11 May 2001 05:48:12 -0400
Received: from 13dyn241.delft.casema.net ([212.64.76.241]:6153 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S137089AbREKJsG>; Fri, 11 May 2001 05:48:06 -0400
Message-Id: <200105110947.LAA18167@cave.bitwizard.nl>
Subject: Source code compatibility in Stable series????
To: linux-kernel@vger.kernel.org
Date: Fri, 11 May 2001 11:47:59 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems that in 2.4.4 suddenly the function "skb_cow" no longer
returns the modified skb, but it retuns and integer for
succes/failure.

This means that for networking modules requiring this function, there
is no source code compatibilty between 2.4.3 and 2.4.4.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

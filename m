Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312888AbSDJMBE>; Wed, 10 Apr 2002 08:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312903AbSDJMBD>; Wed, 10 Apr 2002 08:01:03 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:12244 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S312888AbSDJMBC>; Wed, 10 Apr 2002 08:01:02 -0400
From: <benh@kernel.crashing.org>
To: Peter Horton <pdh@berserk.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radeon frame buffer driver
Date: Wed, 10 Apr 2002 14:00:19 +0100
Message-Id: <20020410130019.16655@mailhost.mipsys.com>
In-Reply-To: <20020410101913.GA975@berserk.demon.co.uk>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The colour map is only used by the kernel and the kernel only uses 16
>entries so there isn't any reason to waste memory by making it any
>larger. I checked a few other drivers and they do the same (aty128fb for
>one).

Well, I wouldn't use aty128fb as a reference ;) Though I agree that
if it's really only used for the kernel console, we don't care.

Ben.



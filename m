Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVDYJey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVDYJey (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVDYJey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:34:54 -0400
Received: from f26.mail.ru ([194.67.57.194]:34057 "EHLO f26.mail.ru")
	by vger.kernel.org with ESMTP id S262558AbVDYJev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:34:51 -0400
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/FlashPoint.c: cleanups
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [213.33.157.138]
Date: Mon, 25 Apr 2005 13:34:49 +0400
In-Reply-To: <20050423221712.GJ4355@stusta.de>
Reply-To: Alexey Dobriyan <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1DPzzN-000J3V-00.adobriyan-mail-ru@f26.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch contains cleanups including the following:
> - remove #ifdef'ed code for other OS's
> - remove other unused code
> - make needlessly global code static

FYI, (1) and part of your (2) are already sitting in -kj (splitted).

http://coderock.org/kj/2.6.12-rc3-kj/split/defines-drivers_scsi_FlashPoint.patch
http://coderock.org/kj/2.6.12-rc3-kj/split/comments-drivers_scsi_FlashPoint

And I hope cleaning FlashPoint mess will be splitted.

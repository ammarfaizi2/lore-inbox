Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWEJHFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWEJHFs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWEJHFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:05:48 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:53150 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751208AbWEJHFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:05:47 -0400
Date: Wed, 10 May 2006 09:05:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing
In-Reply-To: <200605100131.02692.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.61.0605100904250.27657@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0604022005290.12603@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0605082211580.20743@yvahk01.tjqt.qr> <44604977.1090008@ums.usu.ru>
 <200605100131.02692.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just for the archive...
>
>On Tuesday, 9. May 2006 09:49, Alexander E. Patrakov wrote:
>> Both the current situation and my patch share the defect that an accent 
>> cannot be put on top of a multibyte character, such as Greek letter alpha.

With 80x25, that [almost] would not be possible either because of the 256 
character limit. Of course the concern is totally valid for fbterm.


Jan Engelhardt
-- 

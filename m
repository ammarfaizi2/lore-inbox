Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbUKBSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbUKBSir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUKBSir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:38:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5829 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261280AbUKBSie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:38:34 -0500
Date: Tue, 2 Nov 2004 19:38:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [oops] lib/vsprintf.c
In-Reply-To: <200411021934.38802.pluto@pld-linux.org>
Message-ID: <Pine.LNX.4.53.0411021937460.13120@yvahk01.tjqt.qr>
References: <200411020719.55570.pluto@pld-linux.org>
 <Pine.LNX.4.53.0411020802410.13921@yvahk01.tjqt.qr> <200411021934.38802.pluto@pld-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You do know that %s does not mix with 1.4?
>
>Yes, I known. I did it intentionally.
>IMHO kernel should be more resistant to accidental programmers errors.
>Be secure, trust no one ;)

Well usually it should be. include/linux/kernel.h has the __attribute__(printf)
stuff for the print[fk]* family.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de

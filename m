Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbUKPT1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUKPT1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUKPTZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:25:25 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:49081 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262111AbUKPTZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:25:01 -0500
Date: Tue, 16 Nov 2004 20:24:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: greg@kroah.com, rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.53.0411162023001.24131@yvahk01.tjqt.qr>
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com>
 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz>
 <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
 <E1CU6SL-0007FP-00@dorka.pomaz.szeredi.hu> <20041116170339.GD6264@kroah.com>
 <E1CU7Tg-0007O8-00@dorka.pomaz.szeredi.hu> <20041116175857.GA9213@kroah.com>
 <E1CU8hS-0007U5-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No, I think reserving a number is still necessary: there seems to be
>only a very small space for dynamically registered misc devices (max
>15), so that's not any better than reserving a static one.

15? But include/linux/miscdevice.h lists more than 20 static numbers for
possibly-going-to-be-loaded-modules!


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbUK0TYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbUK0TYv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUK0TYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:24:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:38294 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261314AbUK0TY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:24:26 -0500
Date: Sat, 27 Nov 2004 20:24:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Javier Villavicencio <javierv@migraciones.gov.ar>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: no entropy and no output at /dev/random  (quick question)
In-Reply-To: <41A804CD.5070007@migraciones.gov.ar>
Message-ID: <Pine.LNX.4.53.0411272023400.27610@yvahk01.tjqt.qr>
References: <41A7EDA1.5000609@migraciones.gov.ar> <41A804CD.5070007@migraciones.gov.ar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Is this a normal behaviour?, or, I think i've readed this somewhere,

Yes, standard behavior. Programs using /dev/random even request you to hit a
few keys or move the mouse.

>it's encouraged to use /dev/urandom instead of /dev/random?

Yes, because 'random' might run out of entropy.

>

Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de

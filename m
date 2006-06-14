Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWFNJdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWFNJdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 05:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWFNJdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 05:33:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:33517 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932219AbWFNJdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 05:33:31 -0400
Date: Wed, 14 Jun 2006 11:33:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
cc: Avuton Olrich <avuton@gmail.com>, Russell Whitaker <russ@ashlandhome.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.19 + gcc-4.1.1
In-Reply-To: <448F8C53.5010406@ens-lyon.org>
Message-ID: <Pine.LNX.4.61.0606141132190.5349@yvahk01.tjqt.qr>
References: <Pine.LNX.4.63.0606131906230.2368@bigred.russwhit.org>
 <3aa654a40606132049u43f81ee1m263ee15666246152@mail.gmail.com>
 <448F8C53.5010406@ens-lyon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Actually, "make modules" does not exist anymore with 2.6. Both built-in
>and modular stuff are built at the same time.
>Only "make modules_install" is still required.
>
You can _still_ build bzImage and modules separately.

The _default_ kernel Makefile target though reads (sth. like)

all: bzImage modules


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285048AbRLQIbC>; Mon, 17 Dec 2001 03:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285054AbRLQIax>; Mon, 17 Dec 2001 03:30:53 -0500
Received: from 217-126-161-163.uc.nombres.ttd.es ([217.126.161.163]:4992 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S285048AbRLQIan>; Mon, 17 Dec 2001 03:30:43 -0500
To: cr@sap.com, raul@viadomus.com
Subject: Re: Is /dev/shm needed?
Cc: linux-kernel@vger.kernel.org, rml@tech9.net
Message-Id: <E16FtLQ-00006A-00@DervishD.viadomus.com>
Date: Mon, 17 Dec 2001 09:41:56 +0100
From: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	 Coronado <raul@viadomus.com>
Reply-To: =?ISO-8859-1?Q?Ra=FAl?= =?ISO-8859-1?Q?N=FA=F1ez?= de Arenas
	   Coronado <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Christoph :)

>>     Yes, I knew, I meant the maximum size. I don't want half of the
>> RAM occupied just by a programming mistake ;)))
>What I like most about /tmp in tmpfs is the ability to resize on the
>fly
[...]
>When one of these gets full I can either stop the affending job or
>increase the limit

    That's one of my doubts: if the available RAM decreases then the
buffer (disk) cache will do too. So, if I have /tmp mounted with
tmpfs, the contents here will be cached no matter the available RAM,
or am I completely wrong?

    Raúl

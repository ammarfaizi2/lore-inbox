Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbUJZDUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbUJZDUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbUJZCxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:53:17 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21483 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262118AbUJZChJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:37:09 -0400
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410250822.46023.dtor_core@ameritech.net>
References: <200410210154.58301.dtor_core@ameritech.net>
	 <20041025125629.GF6027@crusoe.alcove-fr>
	 <200410250822.46023.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1098744035.7191.49.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 26 Oct 2004 12:28:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-10-25 at 23:22, Dmitry Torokhov wrote:
> The change from sysdev to a platform device is the main reason I did
> the change (and getting rid of old pm_register stuff which is useless
> now) because swsusp2 (and seems that swsusp1 as well) have trouble
> resuming system devices. The rest was just fluff really.

I'm not sure why we're not trying to resume system devices. I'll give it
a whirl and see if anything breaks :> Feel free to tell me if/when you
notice things like this in future; I try to be approachable and
responsive.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.


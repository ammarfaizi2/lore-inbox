Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVC1Tdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVC1Tdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVC1Tdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:33:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45448 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262020AbVC1Tdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:33:47 -0500
Date: Mon, 28 Mar 2005 21:33:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: folkert@vanheusden.com
cc: 20050323135317.GA22959@roonstrasse.net, linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <20050328175614.GG943@vanheusden.com>
Message-ID: <Pine.LNX.4.61.0503282131560.11428@yvahk01.tjqt.qr>
References: <20050328172820.GA31571@linux.ensimag.fr> <20050328175614.GG943@vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think per user limit could be a solution.
>> attached a small fork-memory bombing.

I already posted one, posts ago.

>>[snip]

>Imporved version:
>[snip]
>char *dummy = (char *)malloc(1);

That cast is not supposed to be there, is it? (To pretake it: it's bad.)


Jan Engelhardt
-- 
No TOFU for me, please.

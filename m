Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758211AbWK0Nrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758211AbWK0Nrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758213AbWK0Nrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:47:39 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:53911 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1758211AbWK0Nrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:47:39 -0500
Message-ID: <456AEC80.2030901@drzeus.cx>
Date: Mon, 27 Nov 2006 14:47:44 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Vitaly Wool <vitalywool@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix "prev->state: 2 != TASK_RUNNING??" problem on SD/MMC
 card removal
References: <20061123184217.a971d267.vitalywool@gmail.com>	 <4569F82E.1040207@drzeus.cx> <acd2a5930611270113t266602dax49ef671aca99d4c8@mail.gmail.com>
In-Reply-To: <acd2a5930611270113t266602dax49ef671aca99d4c8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Wool wrote:
> On 11/26/06, Pierre Ossman <drzeus-mmc@drzeus.cx> wrote:
>> Hmm... I can't find any such requirement in HEAD, or 2.6.18. What kernel
>> are you running?
> 
> 2.6.18 + -rt patches by Ingo.
> 

I guess the check is in the rt set somewhere then.

Anyway, the mmc queue thread has undergone some changes so your patch
needs a bit of a tweak. But I'll put it on my todo and make sure it gets
in during the next merge window.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

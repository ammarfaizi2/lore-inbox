Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291038AbSAaJEf>; Thu, 31 Jan 2002 04:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291039AbSAaJEZ>; Thu, 31 Jan 2002 04:04:25 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:48905 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291038AbSAaJEU>; Thu, 31 Jan 2002 04:04:20 -0500
Date: Thu, 31 Jan 2002 10:04:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dave Jones <davej@suse.de>, Nathan <wfilardo@fuse.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Various issues with 2.5.2-dj6
Message-ID: <20020131100417.B12102@suse.cz>
In-Reply-To: <3C58B3DD.3000800@fuse.net> <20020131041901.H31313@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131041901.H31313@suse.de>; from davej@suse.de on Thu, Jan 31, 2002 at 04:19:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:19:01AM +0100, Dave Jones wrote:

>  > Issue 5: Mouse (via /dev/input/mice) seems slugish this time (after a 
>  > fresh cold boot).  Seemed fine first few times on 2.5.2-dj6 and fine 
>  > under 2.4.18-pre7 /dev/psaux.
> 
>  This is the 2nd report I've had of this. Hopefully Vojtech has
>  an answer for this.

I haven't seen this happen yet, I'll look into the code for explanation,
but if I don't find anything that could cause it, I'll need some debug
data.

(Enabling #define I8042_DEBUG_IO in drivers/input/serio/i8042.h is
usually good enough.)

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWAEWc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWAEWc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWAEWc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:32:58 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46049 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751819AbWAEWc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:32:58 -0500
Date: Thu, 5 Jan 2006 23:32:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sysinterface
Message-ID: <20060105223244.GI2095@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD6B@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD6B@de01exm64.ds.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 17:28:28, Preece Scott-PREECE wrote:
>  
> Not sure if this is the kind of example you're looking for, but...
> 
> We do have devices that may need to stay alive even though the processor has been suspended - for instance, we keep the display backlight on for human-useful periods following the last keypress, but most of the system can be shut down as soon as the work driven from the keypress is finished. The display needs to be able to maintain itself without the processor's help.
> 

No, not that one. That would be more like processor Cx states on PC.

Are there any devices that have multiple "off" modes with
different "latency before device gets functional" values, where we
actually want to use more than one "off" mode?
							Pavel

-- 
Thanks, Sharp!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423699AbWKFKTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423699AbWKFKTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423711AbWKFKTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:19:06 -0500
Received: from def92-3-81-56-114-101.fbx.proxad.net ([81.56.114.101]:49373
	"EHLO barad-dur") by vger.kernel.org with ESMTP id S1423699AbWKFKTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:19:03 -0500
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: could not find filesystem /dev/root
References: <454E95E1.2010708@perkel.com>
From: Mathieu SEGAUD <matt@regala.cx>
Date: Mon, 06 Nov 2006 11:18:59 +0100
In-Reply-To: <454E95E1.2010708@perkel.com> (Marc Perkel's message of "Sun\, 05 Nov 2006 17\:54\:41 -0800")
Message-ID: <873b8wubcc.fsf@barad-dur.regala.cx>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vous m'avez dit récemment :

> Trying to compile a new kernel and getting this on boot
>
> could not find filesystem /dev/root

sure it doesn't spit only this to you. Does it panic ? and do FC6
kernels use an initrd (I guess so) ?

> It boots up fine with the stock FC6 kernel. What am I missing?

many reasons can prevent you from booting a vanilla kernel on modern distros

try to figure out what is really exec'ed _after_ the kernel
initialization and _before_ init execution
(hint: initramfs)

-- 
Mathieu Segaud

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUELMtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUELMtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUELMtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:49:42 -0400
Received: from zork.zork.net ([64.81.246.102]:23239 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264931AbUELMtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:49:41 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
References: <20040510024506.1a9023b6.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
 linux-kernel@vger.kernel.org
Date: Wed, 12 May 2004 13:49:36 +0100
In-Reply-To: <20040510024506.1a9023b6.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 10 May 2004 02:45:06 -0700")
Message-ID: <6ufza5yfmn.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> psmouse-fix-mouse-hotplugging.patch
>   psmouse: fix mouse hotplugging

This change seems to cause psmouse.proto=bare to no longer work as a
way of disabling the passthrough port on my laptop's Synaptics touchpad.
However, the effect is not the same as omitting it entirely; I don't
see a separate entry for the trackpoint[1] in /proc/bus/input/devices.


[1] Faulty trackpoint, in my case.


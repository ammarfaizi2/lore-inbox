Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVKOAai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVKOAai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVKOAai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:30:38 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:64190 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932212AbVKOAah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:30:37 -0500
Date: Mon, 14 Nov 2005 16:30:31 -0800
From: mike kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, haveblue@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] register_ and unregister_memory_notifier should be global
Message-ID: <20051115003031.GA19640@w-mikek2.ibm.com>
References: <exportbomb.1131997056@pinky> <20051114193738.GA15494@shadowen.org> <20051114152316.4060d30c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114152316.4060d30c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 03:23:16PM -0800, Andrew Morton wrote:
> Andy Whitcroft <apw@shadowen.org> wrote:
> >
> > Both register_memory_notifer and unregister_memory_notifier are global
> > and declared so in linux.h.  Update the HOTPLUG specific definitions
> > to match.  This fixes a compile warning when HOTPLUG is enabled.
> 
> There is no linux.h and I can find no .h file which declares
> register_memory_notifier().  Please clarify?

I'm pretty sure Andy meant to say <linux/memory.h> not linux.h.

-- 
Mike

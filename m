Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVA1OZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVA1OZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVA1OZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:25:26 -0500
Received: from styx.suse.cz ([82.119.242.94]:15817 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261404AbVA1OZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:25:22 -0500
Date: Fri, 28 Jan 2005 15:28:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Wiktor <victorjan@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128142826.GA12137@ucw.cz>
References: <41F11F79.3070509@poczta.onet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F11F79.3070509@poczta.onet.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 04:27:53PM +0100, Wiktor wrote:
> Hi,
> 
> my AT keyboard is dead on 2.6 series. Tests on other machines proves 
> that this is my-hardware-specyfic problem (exacly the same binnary works 
> on different mainboards with PS/2 keyboard and another AT keyboard). 2.4 
> series works correctly. On 2.6 kernel seems to not hear what keyboard 
> wants to tell him (eg. atkbd.reset preforms keyboard reset but reports 
> error). Were any hadrware-handling changes made since 2.4? If so, how to 
> undo them and make keyboard alive? I'm grateful for any help.
 
Please try i8042.noaux=1. You say you're using a serial mouse in your
other e-mail, so the system may not have an AUX port yet the kernel
thinks it does. This may cause the keyboard to stop responding.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

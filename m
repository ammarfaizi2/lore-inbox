Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUHPCzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUHPCzG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUHPCzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:55:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:55170 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S267367AbUHPCzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 22:55:01 -0400
Date: Mon, 16 Aug 2004 04:54:54 +0200 (MEST)
Message-Id: <200408160254.i7G2ss3S000656@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: paulus@samba.org
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 08:13:59 +1000, Paul Mackerras wrote:
>Mikael Pettersson writes:
>
>> +/* We need to mark all pages as being coherent if we're SMP or we
>> + * have a 754x and an MPC107 host bridge.
>> + */
>> +#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)
>
>Does CONFIG_MPC10X_BRIDGE mean just MPC107, or is it set for (e.g.)
>systems with a MPC106 as well?

I just copied this part from 2.6.8. Currently it
seems CONFIG_MPC10X_BRIDGE is set for some platforms
(sandpoint and lopec), but it is definitely not set
for MPC106 machines like my beige PowerMac G3.

/Mikael

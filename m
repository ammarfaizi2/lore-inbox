Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266534AbUHPCAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUHPCAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 22:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUHPCAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 22:00:08 -0400
Received: from ozlabs.org ([203.10.76.45]:16077 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266534AbUHPB7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 21:59:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16671.57383.988631.451559@cargo.ozlabs.ibm.com>
Date: Mon, 16 Aug 2004 08:13:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
In-Reply-To: <200408151116.i7FBG9ds029029@harpo.it.uu.se>
References: <200408151116.i7FBG9ds029029@harpo.it.uu.se>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:

> +/* We need to mark all pages as being coherent if we're SMP or we
> + * have a 754x and an MPC107 host bridge.
> + */
> +#if defined(CONFIG_SMP) || defined(CONFIG_MPC10X_BRIDGE)

Does CONFIG_MPC10X_BRIDGE mean just MPC107, or is it set for (e.g.)
systems with a MPC106 as well?

Paul.

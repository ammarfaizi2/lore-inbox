Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbTDUV0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTDUV0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:26:42 -0400
Received: from AMarseille-201-1-3-29.abo.wanadoo.fr ([193.253.250.29]:7207
	"EHLO gaston") by vger.kernel.org with ESMTP id S262549AbTDUV0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:26:41 -0400
Subject: Re: [PATCH] dmasound resurrection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304211847160.24620-100000@callisto>
References: <Pine.LNX.4.44.0304211847160.24620-100000@callisto>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050961045.626.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2003 23:37:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 18:52, Geert Uytterhoeven wrote:
> When ALSA was integrated in 2.5.5, the dmasound drivers were silently removed
> from the build list, and no one noticed. Later the drivers were upgraded but
> some bugs were introduced, and no one noticed.
> 
> The patch below is a first step in reviving the dmasound drivers.
> 
> Any comments from the PPC camp?

The pmac side of dmasound is quite badly outdated in 2.5, I'll look
into updating it, along with some other major driver updates, though
it may take a little while

Ben.

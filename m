Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWC1NrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWC1NrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWC1NrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:47:04 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:58993 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932225AbWC1NrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:47:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=jPVp6uSxDIpnT/jYb3oLbuUpHDVkyJF3PmhWLagOG6nBeyEzdePHRrijnsWNXTVgqpP4T/f1CPaRls9RWVXGUNBAWznRnTYzMnUCiGwlhUd7KGgqRU1Nr0rxFpOGh8QB+3O+tnFRrqbHBw+WtXKoOYk6ESPLf/2+LbmLFvnDnks=
Date: Tue, 28 Mar 2006 15:46:54 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.16-mm2] Kconfig SND_SEQUENCER_OSS help text fix
Message-ID: <20060328134654.GA9671@silenus.home.res>
References: <20060328003508.2b79c050.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328003508.2b79c050.akpm@osdl.org>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The SND_SEQUENCER_OSS config option in sound/core/Kconfig claims it could be 
compiled as a module despite being a bool. This patch removes the misleading
help text. This should apply to 2.6.16 as well, should I resend a patch?

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- linux-2.6.16-mm2/sound/core/Kconfig~        2006-03-28 15:31:43.000000000 +0200
+++ linux-2.6.16-mm2/sound/core/Kconfig 2006-03-28 15:31:55.000000000 +0200
@@ -92,9 +92,6 @@

          Many programs still use the OSS API, so say Y.

-         To compile this driver as a module, choose M here: the module
-         will be called snd-seq-oss.
-
 config SND_RTCTIMER
        tristate "RTC Timer support"
        depends on SND && RTC


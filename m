Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275014AbRJAMyd>; Mon, 1 Oct 2001 08:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275017AbRJAMyX>; Mon, 1 Oct 2001 08:54:23 -0400
Received: from sushi.toad.net ([162.33.130.105]:17812 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S275014AbRJAMyJ>;
	Mon, 1 Oct 2001 08:54:09 -0400
Subject: Re: [PATCH] PnPBIOS 2.4.9-ac1[56] Vaio fix
To: linux-kernel@vger.kernel.org
Date: Mon, 1 Oct 2001 08:54:01 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011001125401.9684B8BF@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian: Okay, thanks for testing it.

Stelian and others:  So the fix works using is_sony_vaio_laptop
to set the pnp_bios_dont_use_current_config flag.  (Alan can
shorten this name if he wants ;)  The is_sony_vaio_laptop
flag is only found in the i386 and x86_64 arches.  Is the
pnpbios driver used on other arches?  If so then we'll have
to provide the flag in those arches or pnpbios won't link.
Alan?

Thomas
-- 
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVJ3TfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVJ3TfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVJ3TfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:35:07 -0500
Received: from ns2.suse.de ([195.135.220.15]:28393 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932226AbVJ3TfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:35:06 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Sun, 30 Oct 2005 20:35:49 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20051030105118.GW4180@stusta.de> <p73mzkqubf4.fsf@verdi.suse.de> <20051030183821.GI4180@stusta.de>
In-Reply-To: <20051030183821.GI4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510302035.49765.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 19:38, Adrian Bunk wrote:

> ???
> 
> $ ls -la sound/oss/i810_audio.o sound/pci/intel8x0.o
> -rw-rw-r--  1 bunk bunk 38056 2005-10-30 13:43 sound/oss/i810_audio.o
> -rw-rw-r--  1 bunk bunk 34344 2005-10-30 13:44 sound/pci/intel8x0.o
> $ 
> 
> The general decision for the OSS -> ALSA move was long ago.

If you compare the complete size of ALSA+driver vs OSS+driver then
OSS wins easily on the bloat department.

> If you have a real issue with the ALSA driver please submit a proper 
> bug report to the ALSA bug tracking system and tell me the bug number.

Avoiding bloat is a real issue.

-Andi

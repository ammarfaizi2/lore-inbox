Return-Path: <linux-kernel-owner+w=401wt.eu-S1761033AbWLHSxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761033AbWLHSxv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761040AbWLHSxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:53:51 -0500
Received: from ag-out-0708.google.com ([72.14.246.241]:48302 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761023AbWLHSxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:53:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VvcwHu4BU1V84iP8B1bCoKmtleq06/zSLaPs2sIS8gJNIUxkU5HiaeRVuMS/mBwLuTABqwX3BW4Iq4MSjF+62PSuw/hsZgjwaf0wJfMVOmil4yCntua/BiUNMaZij8QfuGMWUWI+x0a94exZRJULPmaf+edS2rM2PuFCNYKmT8Q=
Message-ID: <2a6e8c0d0612081053v4fa0f2b0uea82fac75976b767@mail.gmail.com>
Date: Fri, 8 Dec 2006 13:53:46 -0500
From: "Ian E. Morgan" <penguin.wrangler@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, emu10k1-devel@lists.sourceforge.net
Subject: Loud POP from sound system during module init w/ 2.6.19
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading to 2.6.19, two of my boxes (one workstation, one
notebook) started making a very loud (and scary) POP from the sound
system when the alsa modules are loaded. Unloading and reloading the
modules will generate another pop.

I have removed any fiddling of mixer settings during module
load/unload; same results.

I have complied the kernel both with and without
CONFIG_SND_AC97_POWER_SAVE; same results.

The workstation uses snd_emu10k1, the notebook snd_intel8x0, so it's
affecting more than a single driver.

Anybody else seeing this behaviour and know how to stop it?

-- 
Ian E. Morgan
penguin.wrangler@gmail.com

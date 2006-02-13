Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWBMBsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWBMBsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWBMBsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:48:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18315 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751126AbWBMBsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:48:32 -0500
Date: Sun, 12 Feb 2006 20:48:26 -0500
From: Dave Jones <davej@redhat.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AGP serverworks chipset not being initializated properly?
Message-ID: <20060213014826.GA32329@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
References: <20060213022757.bfc2af7f.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213022757.bfc2af7f.diegocg@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 02:27:57AM +0100, Diego Calleja wrote:
 > For a while, I've been having this on my dmesg:
 > 
 > agpgart: Xorg tried to set rate=x12. Setting to AGP3 x8 mode.
 > agpgart: Putting AGP V2 device at 0000:00:00.1 into 2x mode
 > agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
 > [drm] Loading R200 Microcode
 > 
 > This is really weird since my motherboard (CNB20HE chipset)
 > only supports 2x AGP cards and my xorg.conf file has this: 

CNB20HE is unsupported (The failure message should actually
be a little better, I'll go fix that).

Docs on this chipset aren't publically available, so it's
unlikely to happen any time soon.

		Dave


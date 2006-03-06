Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWCFBSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWCFBSH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWCFBSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:18:07 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:14861 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751460AbWCFBSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:18:05 -0500
Date: Mon, 6 Mar 2006 02:17:57 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Is that an acceptable interface change?
Message-ID: <20060306011757.GA21649@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at the changes in the asound.h file, and especially at
commit 512bbd6a85230f16389f0dd51925472e72fc8a91, and I've been
wondering if it's acceptable compatibility-wise.  All the structures
passed through ioctl (and ALSA is 100% ioctl) have been renamed from
sndrv_* to snd_*.  That breaks source compatibility but not binary
compatibility.

Ignoring the fact that the changelog comment utterly fails to mention
that part of the change, is keeping compatibility supposed to be
binary-only or source too?

  OG.


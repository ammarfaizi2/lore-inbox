Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWB0PAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWB0PAU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWB0PAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:00:20 -0500
Received: from [129.59.116.43] ([129.59.116.43]:9627 "EHLO
	compsci.cas.vanderbilt.edu") by vger.kernel.org with ESMTP
	id S1751389AbWB0PAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:00:19 -0500
From: "S. Umar" <umar@compsci.cas.vanderbilt.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Date: Mon, 27 Feb 2006 09:00:13 -0600
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602270900.13654.umar@compsci.cas.vanderbilt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm this as well.

DEVICE:
Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)

SYMPTOMS:

      1. No sound.
      2. kernel: azx_get_response timeout 
          messages in system log
      3. Doing modprobe -r snd_hda_intel and then modprobe snd_hda_intel
          produces "general protection fault: 0000 [1] SMP" message.

I think I have seen another thread on this.

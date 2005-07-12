Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbVGLUYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbVGLUYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGLUYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:24:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33204 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262381AbVGLUYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:24:44 -0400
Date: Tue, 12 Jul 2005 21:24:36 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm2
Message-ID: <20050712202436.GA12341@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050712021724.13b2297a.akpm@osdl.org> <6f6293f10507121116363ff57c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6293f10507121116363ff57c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 08:16:14PM +0200, Felipe Alfaro Solana wrote:
> I'm seeing this oops with 2.6.13-rc2-mm2:
 
> EIP is at suspend_targets+0x6/0x47 [dm_mod]

> Doesn't happen with 2.6.13-rc2-mm1, however.

What's your device-mapper/lvm configuration and what 'lvm' command
did you run to trigger this?

  'dmsetup info -c'
  'dmsetup table'
  'lvs --segments -o+devices -a'

Alasdair


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422799AbWJLHnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbWJLHnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWJLHnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:43:32 -0400
Received: from main.gmane.org ([80.91.229.2]:30381 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422794AbWJLHn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:43:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Early keyboard initialization?
Date: Thu, 12 Oct 2006 09:41:29 +0200
Message-ID: <s0fqclp3bw1f$.1ovr22f673taq$.dlg@40tude.net>
References: <20061006204254.GD5489@bouh.residence.ens-lyon.fr> <200610072158.55659.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-55-226.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006 21:58:54 -0400, Dmitry Torokhov wrote:

> It looks like the change will only work for non-USB input devices since
> USB subsystem is initialized much later.

Doesn't the BIOS handle USB keyboards someway? (To handle BIOS setup
and stuff like that)

If the BIOS emulates a non-USB keyboard, would it be possible to init
the fake one early and then give up control when the USB subsystem is
initialized?

-- 
Giuseppe "Oblomov" Bilotta

"I'm never quite so stupid
 as when I'm being smart" --Linus van Pelt


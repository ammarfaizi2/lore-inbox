Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUCUPbD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 10:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbUCUPbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 10:31:03 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:7935 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S263665AbUCUPbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 10:31:00 -0500
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does Linux sync(2) wait?
In-Reply-To: <1C8xa-5lk-5@gated-at.bofh.it>
References: <1C8xa-5lk-5@gated-at.bofh.it>
Date: Sun, 21 Mar 2004 16:30:53 +0100
Message-Id: <E1B54ub-00004H-OC@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004 11:40:08 +0100, you wrote in linux.kernel:
> Looking at 2.4 and 2.6 sources, Linux does appear to wait before returning.
> I'm especially interested if NFS data is sent to the server.  (I want to
> be able to take a stable snapshot of a netapp volume.)

No idea about NFS, but sync(1) does wait. When I push 500M out to my
MO drive, the cp operation returns fairly quickly because I usually
have more than 500M free memory. Then I run sync(1), which takes about
20 minutes before it returns.

-- 
Ciao,
Pascal

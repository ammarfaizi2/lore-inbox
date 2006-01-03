Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWACOqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWACOqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWACOq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:46:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:38810 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932390AbWACOq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:46:28 -0500
Date: Tue, 3 Jan 2006 15:46:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/26] kbuild: Fix genksyms handling of DEFINE_PER_CPU(struct
 foo_s *, bar);
In-Reply-To: <11362947262643@foobar.com>
Message-ID: <Pine.LNX.4.61.0601031546100.436@yvahk01.tjqt.qr>
References: <11362947262643@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is a one-line change to parse.y.
>To take advantage of this the scripts/genksyms/*_shipped files needs to
>be rebuild - this is the next patch.
>
>When a .c file contains:
>DEFINE_PER_CPU(struct foo_s *, bar);
>
>the .cpp output looks like:
     ^^^^

Are you right about C++?



Jan Engelhardt
-- 

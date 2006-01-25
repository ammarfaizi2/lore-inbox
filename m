Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWAYOcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWAYOcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWAYOcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:32:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18632 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751173AbWAYOcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:32:35 -0500
Date: Wed, 25 Jan 2006 15:26:52 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <acahalan@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, schilling@fokus.fraunhofer.de,
       matthias.andree@gmx.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Where is the difference between SG_IO-on-hdx and sg0?
>
>It's like the /dev/ttyS* and /dev/cua* situation, where
>we also ended up with multiple device files. This is bad.
>
>SG_IO-on-hdx is modern. It properly associates everything
>with one device, which you may name as desired.

Let's analyze a case:
if /dev/sg0 would always be associated with /dev/hda,
/dev/sg1 always with /dev/hdb, no matter if there was actually a
hda/sg0 device present in the system - would that simplify
the problem?


Jan Engelhardt
-- 

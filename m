Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVAHL4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVAHL4T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 06:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVAHL4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 06:56:19 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:467 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261427AbVAHL4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 06:56:17 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 08 Jan 2005 12:56:04 +0100
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2005.01.08.11.55.59.174815@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: hanging a 2.6.10-{vanilla,ck} kernel by copying files over network
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Today I tried to copy ~10GB of file-images (files of size of 100-2000MB
using midnight commander) from a firewire device over 100Mbit network (a
samba share). When doing so, on a freshly booted machine the files to be
copied seem to be put into memory first, making the machine simply run out
of memory and hang (well I can get into xmon and see the machine idleing
there but it is unresponsive elsewise).

The machine here is a powerbook 15" with 1G of memory NO SWAP. The remote
machine also runs linux-2.6.10 and exports this samba share.

2.6.10-vanilla hangs very quickly, 2.6.10-ck1 survives a little longer but
one also observes these hangs.

The reverse direction, i.e. copying from the samba server to the firewire
disk works flawlessly.

Any ideas ?

Soeren.



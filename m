Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbTDIJ2Z (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTDIJ2Y (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:28:24 -0400
Received: from mail.mediaways.net ([193.189.224.113]:65498 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S262981AbTDIJ2X (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:28:23 -0400
Subject: 2.4.21pre6 - devfs+alsa: could not append to parent, err: -17
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1049880820.2774.60.camel@fortknox>
Mime-Version: 1.0
Date: 09 Apr 2003 11:33:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On bootup I get:

devfs_register(audio): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
devfs_register(unknown): could not append to parent, err: -17
ALSA ../../../alsa-kernel/core/seq/oss/seq_oss.c:223: can't register device seq

However the sound devices are there and work fine (emu10k1 and via82xx
sound cards are in the machine).

No Idea what is causing this...

Soeren.


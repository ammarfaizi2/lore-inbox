Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316999AbSFWIed>; Sun, 23 Jun 2002 04:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSFWIec>; Sun, 23 Jun 2002 04:34:32 -0400
Received: from [62.40.73.125] ([62.40.73.125]:17090 "HELO Router")
	by vger.kernel.org with SMTP id <S316999AbSFWIeb>;
	Sun, 23 Jun 2002 04:34:31 -0400
Date: Sun, 23 Jun 2002 10:40:12 +0200
From: clock@atrey.karlin.mff.cuni.cz
To: linux-kernel@vger.kernel.org
Subject: kmalloc size too large
Message-ID: <20020623104012.B532@ghost.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

when dumping tracks from an IDE CD using cdda2wav I sometimes get this kernel
message:

Jun 23 10:34:18 ghost kernel: kmalloc: Size (4294852048) too large
Jun 23 10:34:18 ghost kernel: kmalloc: Size (4294852048) too large
Jun 23 10:37:55 ghost last message repeated 29 times
Jun 23 10:37:55 ghost last message repeated 29 times

It is not deterministic but looks like some tracks cause it often and some not.

Kernel 2.2.20

-- 
Karel 'Clock' Kulhavy

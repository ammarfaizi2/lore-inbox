Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTDJQ0y (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbTDJQ0x (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:26:53 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:34319 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264097AbTDJQ0w (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:26:52 -0400
Date: Thu, 10 Apr 2003 17:38:28 +0100
From: John Levon <levon@movementarian.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] kill two scsi ioctls
Message-ID: <20030410163828.GC93213@compsoc.man.ac.uk>
References: <UTC200304101633.h3AGXQ125592.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304101633.h3AGXQ125592.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Spam-Score: -30.9 (------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *193f4G-000Ppg-Pd*0BiOk7z6oMk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 06:33:26PM +0200, Andries.Brouwer@cwi.nl wrote:

> The definition for SCSI_IOCTL_BENCHMARK_COMMAND was added in 1.1.2.
> The definition for SCSI_IOCTL_SYNC was added in 1.1.38.
> Neither of them has ever been used.

Can't you at least add a comment about what was there ? It's quite
annoying to come across :

#define FOO 1
#define BAR 2
#define BAZ 5

and have no idea why

regards
john

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWAVIQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWAVIQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWAVIQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:16:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932174AbWAVIQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:16:41 -0500
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
From: Arjan van de Ven <arjan@infradead.org>
To: Ariel <askernel2615@dsgml.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 09:16:38 +0100
Message-Id: <1137917798.3328.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-21 at 21:13 -0500, Ariel wrote:
> I have a memory leak in scsi_cmd_cache.
> 
> Attached is a pretty graph made by munin, and you can see slab_cache 
> growing constantly since last reboot. Also attached is /proc/config.gz
> 
> And here is a copy of /proc/meminfo and /proc/slabinfo
> 
> I'm rebooting now since my system is all but unusable (so the mem stats 
> will reset), but if you need any more info let me know.


does this happen without the binary nvidia driver too? (it appears
you're using that). That's a good datapoint to have if so...


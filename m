Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbUKQUJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbUKQUJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbUKQSEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:04:44 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:55508 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262449AbUKQSAk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:00:40 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 17 Nov 2004 18:39:24 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move EXPORT_SYMBOL(bttv_i2c_call)
Message-ID: <20041117173924.GE8176@bytesex>
References: <20041116011834.GF4946@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116011834.GF4946@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 02:18:34AM +0100, Adrian Bunk wrote:
> The patch below moves the EXPORT_SYMBOL(bttv_i2c_call) to the file where 
> the actual function is.

Should be the other way around: bttv_i2c_call() belongs into bttv-if.c.
Done in cvs.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)

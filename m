Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbTAPWbc>; Thu, 16 Jan 2003 17:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbTAPWbc>; Thu, 16 Jan 2003 17:31:32 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:48887 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267303AbTAPWbb>; Thu, 16 Jan 2003 17:31:31 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200301161814.h0GIEbb02258@linux.local> 
References: <200301161814.h0GIEbb02258@linux.local> 
To: jim.houston@attbi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] IDE OnTrack remap for 2.5.58 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Jan 2003 22:40:24 +0000
Message-ID: <14093.1042756824@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jim.houston@attbi.com said:
> +#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)

Don't ever do that. Modules can be built later and shouldn't affect the 
static kernel unless it's _absolutely_ necessary. And were these weird 
partitioning schemes specific to IDE anyway?

--
dwmw2



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267353AbTBVTbJ>; Sat, 22 Feb 2003 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTBVTbJ>; Sat, 22 Feb 2003 14:31:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43650
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267353AbTBVTbI>; Sat, 22 Feb 2003 14:31:08 -0500
Subject: Re: [BUG][2.5.61-ac1] ide-scsi and ZIP
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302220737450.1200-200000@bilbo.tmr.com>
References: <Pine.LNX.4.44.0302220737450.1200-200000@bilbo.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045946499.5484.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 20:41:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 12:42, Bill Davidsen wrote:
> When loading ide-scsi kernel get a BUG while looking at the ZIP drive. 
> Yes, I can get around it with config, but it shouldn't BUG me.

The ide_xlate change is broken for non IDE devices (like scsi even when its
ide-scsi).


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUFQTiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUFQTiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUFQTiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:38:11 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:47378 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S262794AbUFQThm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:37:42 -0400
Date: Thu, 17 Jun 2004 21:37:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: hfs warning in 2.4.27-pre6
In-Reply-To: <Pine.GSO.4.58.0406172106390.1495@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0406172134220.10292@scrub.local>
References: <Pine.GSO.4.58.0406172106390.1495@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:

> Not a new one:
> 
> | super.c: In function `parse_options':
> | super.c:164: warning: `names' might be used uninitialized in this function
> | super.c:164: warning: `fork' might be used uninitialized in this function
> 
> and it's not a compiler glitch.

Eek, the only halfway sane and simple solution would be to disable 
parse_options() for remount completely, so it will always be initialized.

bye, Roman

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268382AbTBNNRM>; Fri, 14 Feb 2003 08:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268395AbTBNNRL>; Fri, 14 Feb 2003 08:17:11 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:47765 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S268382AbTBNNRK>; Fri, 14 Feb 2003 08:17:10 -0500
Date: Fri, 14 Feb 2003 14:26:43 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Polychronis Ypodimatopoulos <ypol@intracom.gr>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Subject: Re: PROBLEM: in Config.in
Message-ID: <20030214132643.GA27446@wohnheim.fh-wedel.de>
References: <1045213608.4604.13.camel@pcypol.intranet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1045213608.4604.13.camel@pcypol.intranet.gr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 February 2003 11:06:48 +0200, Polychronis Ypodimatopoulos wrote:
> 
> File: /usr/src/linux/drivers/char/Config.in, line 152:
> 
> if [ "$CONFIG_PPC64" ] ; then
> 
> should be
> 
> if [ "$CONFIG_PPC64" = "y" ] ; then
> 
> right?

Either way, it doesn't hurt anything but the taste of the reader. Paul
added the Hypervisor (although Marcelo added the Config.in entry), so
let's see if it hurts his taste.

Jörn

-- 
Rules of Optimization:
Rule 1: Don't do it.
Rule 2 (for experts only): Don't do it yet.
-- M.A. Jackson 

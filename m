Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268207AbTBNFuh>; Fri, 14 Feb 2003 00:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268210AbTBNFuh>; Fri, 14 Feb 2003 00:50:37 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:60561 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S268207AbTBNFug>; Fri, 14 Feb 2003 00:50:36 -0500
Date: Fri, 14 Feb 2003 08:00:24 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: modutils that works with 2.4 and 2.5?
Message-ID: <20030214060024.GC9578@actcom.co.il>
References: <1045162343.1311.7.camel@mentor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045162343.1311.7.camel@mentor>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 11:52:23AM -0700, Dax Kelson wrote:
> Does such a thing exist?
> 
> I would like to help out testing 2.5, but I need to still use 2.4 as
> well.

Rusty's modutils package maintains the old modutils binaries and falls
back to them if it discovers that you're running a 2.4 system. If
you're installing from source, take a look at the documentation for
how to tell the Makefile to rename your $MODULE_BIN to
$MODULE_BIN.old
-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net


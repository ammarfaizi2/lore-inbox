Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWDBIKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWDBIKR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWDBIKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:10:17 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:53949 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S932090AbWDBIKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:10:16 -0400
Date: Sun, 2 Apr 2006 10:10:14 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Blue Fox <blue_fox33@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: make menuconfig fails under 2.6.16
Message-ID: <20060402081014.GA26086@fiberbit.xs4all.nl>
References: <20060401182258.GA30539@fiberbit.xs4all.nl> <BAY110-F1201ECD426A949996E3F11FFD40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <BAY110-F1201ECD426A949996E3F11FFD40@phx.gbl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday April 2nd 2006 at 08:33 uur Blue Fox wrote:

> Thank you for information.
> 
> I am using Linux from Scratch. NCURSES is part of the installation process. 
> /usr/lib/libncurses.so is installed on the system. After analysing the 
> problem I encountered that it has to be a link to /lib/libncurses.so.5 
> which is a link to libncurses.so.5.5.
> 
> The link in my /usr/lib was broken. After restoring it, build is working.

Ok, these library links are normally automatically created by running
'ldconfig'. You can always rerun this by hand at any time.

Anyway this is getting highly offtopic! And remember you can always use
"make config" or "make oldconfig" (if you had an earlier .config) to get
along even without "graphical" configurators. ;-)
-- 
Marco Roeland

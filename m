Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTD1DIt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 23:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTD1DIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 23:08:49 -0400
Received: from almesberger.net ([63.105.73.239]:8211 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261309AbTD1DIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 23:08:48 -0400
Date: Mon, 28 Apr 2003 00:20:57 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Rafael Santos <rafael@thinkfreak.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFD] Combined fork-exec syscall.
Message-ID: <20030428002057.A13069@almesberger.net>
References: <20030427234215.D16041@almesberger.net> <0FEZ108QF0E0ZT86OYT835Z64PJ.3eade7da@rafaelnote.ns1.lhost.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0FEZ108QF0E0ZT86OYT835Z64PJ.3eade7da@rafaelnote.ns1.lhost.com.br>; from rafael@thinkfreak.com.br on Mon, Apr 28, 2003 at 11:47:54PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Santos wrote:
> This is not the point.

It avoids kernel.c:copy_files and the ensuing close(2) orgy.
You can already avoid MM duplication with CLONE_VM. CLONE_VFORK
gives you synchronization. What else is the point ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

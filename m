Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTLXRcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTLXRcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:32:10 -0500
Received: from nevyn.them.org ([66.93.172.17]:61392 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263464AbTLXRcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:32:08 -0500
Date: Wed, 24 Dec 2003 12:32:05 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KGDB: automatic loading of modules in gdb
Message-ID: <20031224173205.GA27219@nevyn.them.org>
Mail-Followup-To: "Amit S. Kale" <amitkale@emsyssoft.com>,
	linux-kernel@vger.kernel.org
References: <200312231818.03072.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312231818.03072.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 06:18:02PM +0530, Amit S. Kale wrote:
> Hi,
> 
> I have integrated a couple of kgdb features from TimeSys Linux distribution.
> 
> 1.  Automatic loading of module files in gdb:
> A special version of gdb is provided with this feature. It can detect loading 
> and unloading of modules in a kernel. Whenever a module is loaded, gdb loads 
> the module object file and makes it available for debugging. loadmodule.sh 
> script is no longer needed.

Have you or TimeSys, oh, I don't know, considered sending information
about this feature to the GDB developers so that KGDB does not require
a custom version of the GDB client?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

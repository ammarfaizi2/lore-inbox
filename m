Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTFKUhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFKUhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:37:00 -0400
Received: from zamok.crans.org ([138.231.136.6]:26861 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S264476AbTFKU1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:27:15 -0400
Date: Wed, 11 Jun 2003 22:40:58 +0200
To: Jay Denebeim <denebeim@deepthot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build problems with Linux 2.5
Message-ID: <20030611204058.GA18768@darwin.crans.org>
References: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.4i
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:26:33PM -0700, Jay Denebeim wrote:
>   The problem I'm having seems to be related to modutils.  When I make 
> very many modules I can't install the system because depmod can't find 
> symbols undery 2.4.  However using nm I can see that those symbols are 
> indeed defined.  If I make a bare bones system and only have the two or 
> three modules I need (I'm working with SCSI device drivers and need to 
> unload/reload the modules) the depmod passes, but the modprobe fails with 
> QM_MODULES: function unimplemented.

you have to install module-init-tools (0.9.12 latest)

(isn't it in the FAQ ?)
-- 
Tab

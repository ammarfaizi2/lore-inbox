Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbTIVQtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 12:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbTIVQtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 12:49:18 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:11529 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263229AbTIVQtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 12:49:17 -0400
Date: Mon, 22 Sep 2003 17:49:16 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: unknown symbols loading modules under 2.6.x
Message-ID: <20030922164916.GA12729@compsoc.man.ac.uk>
References: <E1A1TE1-00075s-00@speech.braille.uwo.ca> <20030922091800.3b2532ec.rddunlap@osdl.org> <20030922163432.GA3208@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922163432.GA3208@mars.ravnborg.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A1TsC-000LiN-Bq*230vQAgi/X.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 06:34:32PM +0200, Sam Ravnborg wrote:

> Also make sure that you use kbuild when compiling your module.

Talking of which, how hard would it be to fix make clean and make
modules_install for this ?

Current make clean with SUBDIRS set still cleans out the entire kernel
tree, and modules_install wipes out the entire target modules directory.

It would be nice to see at least the latter fixed so there's a simple
way for building modules against 2.6 series (especially since it's
already way nicer than the contortions for 2.2 and 2.4).

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.

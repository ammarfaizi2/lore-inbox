Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264491AbTFEHCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 03:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTFEHCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 03:02:09 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:5367 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264491AbTFEHCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 03:02:08 -0400
Subject: Re: Why am I getting Kernel Panic VFS cannot mount root fs on 301?
From: Martin Schlemmer <azarah@gentoo.org>
To: Joe Burks <jburks@wavicle.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <200306050007.39267.jburks@wavicle.org>
References: <200306041412.27897.jburks@wavicle.org>
	 <20030604213950.GC2436@hh.idb.hist.no>
	 <200306050007.39267.jburks@wavicle.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054796597.5279.46.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 05 Jun 2003 09:03:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 09:07, Joe Burks wrote:
> enu).  All is relatively working now (I can't seem to open a console in X 
> windows if I have devfs built - I think this has something to do with 
> securetty, but I've made the devfs changes to that file and it is still not 
> working).
> 

>From 2.5.68 somewhere you need devpts support compiled in again
(was cut from devfs), and need to mount it to /dev/pts ....


-- 
Martin Schlemmer



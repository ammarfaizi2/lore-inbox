Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTEBXJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 19:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTEBXJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 19:09:44 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:11245 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S263202AbTEBXJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 19:09:43 -0400
Date: Sat, 3 May 2003 00:22:06 +0100 (BST)
From: Matt Bernstein <mb--lkml@dcs.qmul.ac.uk>
To: Steven Cole <elenstev@mesatop.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
In-Reply-To: <1051910420.2166.55.camel@spc9.esa.lanl.gov>
Message-ID: <Pine.LNX.4.55.0305030014130.1304@jester.mews>
References: <20030502020149.1ec3e54f.akpm@digeo.com> 
 <1051905879.2166.34.camel@spc9.esa.lanl.gov>  <20030502133405.57207c48.akpm@digeo.com>
  <1051908541.2166.40.camel@spc9.esa.lanl.gov>  <20030502140508.02d13449.akpm@digeo.com>
 <1051910420.2166.55.camel@spc9.esa.lanl.gov>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (19Bjqt-0006cc-GH)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19Bjqx-0000c5-1W)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 2 Steven Cole wrote:

>Here is a snippet from dmesg output for a successful kexec e100 boot:

Bizarrely I have a nasty crash on modprobing e100 *without* kexec (having
previously modprobed unix, af_packet and mii) and then trying to modprobe
serio (which then deadlocks the machine).

	http://www.dcs.qmul.ac.uk/~mb/oops/

More information available on request

Matt

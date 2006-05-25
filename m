Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWEYVfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWEYVfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWEYVfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:35:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030436AbWEYVfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:35:07 -0400
Date: Thu, 25 May 2006 17:35:00 -0400
From: Dave Jones <davej@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060525213500.GA6227@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Valdis.Kletnieks@vt.edu,
	devmazumdar <dev@opensound.com>, linux-kernel@vger.kernel.org
References: <e55715+usls@eGroups.com> <200605252129.k4PLTx1r018031@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605252129.k4PLTx1r018031@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 05:29:59PM -0400, Valdis.Kletnieks@vt.edu wrote:
 > Might want to look at the symlink at /lib/modules/`uname -r`/source which
 > is probably as sane as it gets... (Though admittedly Fedora points it
 > into the wild blue yonder of /usr/src/kernels/`uname -r` which isn't
 > where the non-existent kernel-source RPM puts it.  Getting the .src.rpm
 > and working from there leaves it in /usr/src/redhat/BUILD/yadda-yadda....)

It's pointing at the files installed by the kernel-devel package.

		Dave
-- 
http://www.codemonkey.org.uk

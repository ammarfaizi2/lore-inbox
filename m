Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUGLWJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUGLWJi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 18:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUGLWJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 18:09:38 -0400
Received: from havoc.gtf.org ([216.162.42.101]:18152 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263875AbUGLWJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 18:09:36 -0400
Date: Mon, 12 Jul 2004 18:09:35 -0400
From: David Eger <eger@havoc.gtf.org>
To: linux-kernel@vger.kernel.org
Subject: pmac_zilog: driver loads (and crashes) without hardware..
Message-ID: <20040712220935.GA20049@havoc.gtf.org>
References: <20040712075113.GB19875@havoc.gtf.org> <20040712082104.GA22366@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712082104.GA22366@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tracked the problem down my oops to the default config compiling
PMAC_ZILOG.  This serial driver does not make my TiBook happy.  I'm
working on a patch to disable this in the ppc/defconfig and hopefully
I can figure how to make this driver more sane if no zilog is present...

-dte

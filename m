Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbVBDHyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbVBDHyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 02:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbVBDHqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 02:46:20 -0500
Received: from [129.183.4.8] ([129.183.4.8]:4224 "EHLO ecfrec.frec.bull.fr")
	by vger.kernel.org with ESMTP id S263360AbVBDHig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 02:38:36 -0500
Subject: Re:
	move-accounting-function-calls-out-of-critical-vm-code-paths.patch
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       jlan@sgi.com, Tim Schmielau <tim@physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0502040130230.5666@gockel.physik3.uni-rostock.de>
References: <20050110184617.3ca8d414.akpm@osdl.org>
	 <Pine.LNX.4.58.0502031319440.25268@schroedinger.engr.sgi.com>
	 <20050203140904.7c67a144.akpm@osdl.org>
	 <Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com>
	 <20050203150551.4d88f210.akpm@osdl.org>
	 <Pine.LNX.4.53.0502040130230.5666@gockel.physik3.uni-rostock.de>
Date: Fri, 04 Feb 2005 08:38:25 +0100
Message-Id: <1107502705.8874.42.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/02/2005 08:47:00,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/02/2005 08:47:08,
	Serialize complete at 04/02/2005 08:47:08
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Andrew Morton wrote:
> Which implies that we need to see some additional accounting code, so we
> can verify that the base accumulation infrastructure is doing the expected
> thing.  As well as an ack from the interested parties.  Does anyone know
> what's happening with all the new accounting initiatives?  I'm seeing no
> activity at all.

I'm following this discussion with a lot of interest. I'm working on a
user space tool for managing groups of processes in order to do
per-group accounting (ELSA). A release should be done quickly. To get
accounting values I'm using BSD per-process accounting and also the CSA
patch. Thus, I'm not directly working on accounting values and the
infrastructure provided by Christoph and CSA patch fit well with my
needs.

Best regards,
Guillaume


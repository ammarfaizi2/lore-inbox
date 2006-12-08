Return-Path: <linux-kernel-owner+w=401wt.eu-S968840AbWLHThA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968840AbWLHThA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968839AbWLHThA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:37:00 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43969 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968837AbWLHTg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:36:59 -0500
Date: Fri, 8 Dec 2006 13:36:57 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH 0/2] file capabilities: two bugfixes
Message-ID: <20061208193657.GB18566@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an lwn.net article, Jonathan Corbet made two very helpful comments
about the file capabilities patch currently being tested in -mm.  The
first is that capabilities are being honored on nosuid filesystems.
The other is that root can lose capabilities by executing files with
only some capabilities set.  The next two patches change these
behaviors.

thanks,
-serge

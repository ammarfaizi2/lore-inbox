Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVBPP7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVBPP7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262057AbVBPP7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:59:45 -0500
Received: from sd291.sivit.org ([194.146.225.122]:15491 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262055AbVBPP7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:59:25 -0500
Date: Wed, 16 Feb 2005 17:01:04 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] Linux Kernel SVN Howto - part two
Message-ID: <20050216160104.GD4372@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ ... Hoping this message will get past the vger filters and will
  not continue the BK flamewar ... ]

[ ... in fact it did not pass the taboo filters, I modified the
  $subject to pass. I feel it would be better if the list admins
  publicly announced when a subject is being tabooed instead of
  silenty doing it. Think at those reading the archives later... ]

I've updated my Subversion kernel howto and did some work on the
import scripts:
	http://www.popies.net/svn-kernel/

There are now two possibilities to convert the bkcvs repository
into a SVN one:
	* either using the original Ben Collins script, which will
	  map one Linus' changeset into a SVN revision (but all the
	  changesets which occured on another branch and got merged
	  by Linus will be packed into one single SVN revision)

	* or using my modified script which analyses the file deltas
	  and tries to recreate the original changesets (based on the
	  assumption that the log messages for every file involved
	  in a changeset is identical). It works pretty well, if a
	  file hasn't been modified several times on a branch.

The repository creation instructions have also changed a bit, 
improving the time necessary to do the conversion (on my AMD 2000+
I can create the full 2.6 repository in 2 hours using the first
script, 5 hours using the second script).

Feedback welcomed.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

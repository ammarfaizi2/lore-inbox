Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966065AbWKIWmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966065AbWKIWmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966066AbWKIWmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:42:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34986 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966064AbWKIWmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:42:07 -0500
Date: Thu, 9 Nov 2006 23:41:57 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: util-linux: orphan
Message-ID: <20061109224157.GH4324@petra.dvoda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 It really seems that util-linux project is in a bad condition:

  * the latest *major* stable release: 05-Mar-2004 (util-linux-2.12a)
  * the latest *minor* stable release: 23-Sep-2005 (util-linux-2.12r)
  * the latest unstable release:       05-Mar-2006 (util-linux-2.13-pre7)
  * missing source code repository
  * missing web page
  * maintainer (Adrian Bunk) completely ignores mails about this package
  * source code doesn't follow linux kernel, because there isn't any
    development
  * contributors are sending their patches to distributions rather than 
    to upstream
  * Red Hat (FC6) has 75 patches for this package (!)
  * Novell has (OpenSuse 10.2) 53 patches for this package (!)
 

 I'm Red Hat util-linux maintainer (for 2 years) and I'd like to
 change this bad situation. Yes.. I'd like to help. I've already
 talked with Peter Anvin about git repository for this project at
 kernel.org. Also I have feedback from Novell that they agree that the
 current situation is bad and they want to contribute future
 development.

 My plan:
 
  * create git repo (stable and unstable branches) at kernel.org
  * create some web page with basic pkg description, TODO, changelogs
  * open util-linux development for more people 
  * merge importantpatches from distros to the upstream code and
    release 2.13 as stable
  * prepare plans for future development:
      - don't maintain duplicate code and use libblkid/libvolumeid only
      - completely remove NFS code (we have nfs-utils and
        /sbin/mount.nfs)
      - write modular libmount and use it in other projects (am-utils,
        autofs, mount.cif, mount.nfs, ...)
      - ???

 I've originally thought about util-linux upstream fork, but as
 usually an fork is bad step. So.. I'd like to start some discussion
 before this step. Maybe Adrian will be realistic and he will leave
 the project and invest all his time to kernel only.


    Karel
	
-- 
 Karel Zak  <kzak@redhat.com>

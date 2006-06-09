Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWFIQyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWFIQyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965299AbWFIQyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:54:23 -0400
Received: from cernmx05.cern.ch ([137.138.166.161]:43669 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S965297AbWFIQyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:54:21 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=RSuaLlo3KVCFI+k0ESL/YXbyO2xgkfyQzBsMjPuVaPYWoC9Fm4ei3ZfmHz6yseOVu962SwaJq/bc91X38gBC/EyrTUtbUm/YHxIUb71yM0qW5FX/tIDGarcLm7Ns1Y3b;
Keywords: CERN SpamKiller Note: -52 Charset: west-latin
X-Filter: CERNMX05 CERN MX v2.0 051012.1312 Release
Date: Fri, 9 Jun 2006 18:54:18 +0200
From: KELEMEN Peter <Peter.Kelemen@cern.ch>
To: Alex Tomas <alex@clusterfs.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609165418.GF30631@chihiro.cern.ch>
Mail-Followup-To: Alex Tomas <alex@clusterfs.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jeff@garzik.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org> <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3k67qb7hr.fsf@bzzz.home.net>
Organization: CERN European Laboratory for Particle Physics, Switzerland
X-GPG-KeyID: 1024D/9FF0CABE 2004-04-03
X-GPG-Fingerprint: 6C9E 5917 3B06 E4EE 6356  7BF0 8F3E CAB6 9FF0 CABE
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 09 Jun 2006 16:54:19.0088 (UTC) FILETIME=[596F5D00:01C68BE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Tomas (alex@clusterfs.com) [20060609 20:48]:

> I think about extents as a step-by-step way ...

...so call it ext4 *now* and have a complete rewrite of the whole
codebase as ext5.  Users get what they want now (ext4) and Linus
gets what he wants later (ext5).  Extents are useful for Joe
Average User with <2 TB filesystems as well.

It's already funny enough that I'm using e2* tools for managing
ext3 filesystems...

Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \     Peter.Kelemen@cern.ch
.+'         `+...+'         `+...+'         `+...+'         `+...+'

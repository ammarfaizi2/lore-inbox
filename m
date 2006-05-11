Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbWEKRwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbWEKRwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWEKRwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:52:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030397AbWEKRwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:52:33 -0400
Date: Thu, 11 May 2006 13:51:43 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sfrench@us.ibm.com, stable@kernel.org,
       urban@teststation.com
Subject: Re: + deprecate-smbfs-in-favour-of-cifs.patch added to -mm tree
Message-ID: <20060511175143.GH25646@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, sfrench@us.ibm.com,
	stable@kernel.org, urban@teststation.com
References: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605110717.k4B7HuVW006999@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 12:15:10AM -0700, Andrew Morton wrote:
 > 
 > The patch titled
 > 
 >      deprecate smbfs in favour of cifs
 > 
 > has been added to the -mm tree.  Its filename is
 > 
 >      deprecate-smbfs-in-favour-of-cifs.patch
 > 
 > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
 > out what to do about this
 > 
 > 
 > From: Andrew Morton <akpm@osdl.org>
 > 
 > smbfs is a bit buggy and has no maintainer.  Change it to shout at the user on
 > the first five mount attempts - tell them to switch to CIFS.
 > 
 > Come November we'll mark it BROKEN and see what happens.


For Fedora Core 5, I disabled SMBFS for pretty much the same reasons.
Users migrating to CIFS haven't really had any problems so far, except for
this case: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=186914
(Which has also come up a few times on Fedora mailing lists since).

I mailed Steve about this, and he did reply, but I can't seem to find it
right now

		Dave

-- 
http://www.codemonkey.org.uk

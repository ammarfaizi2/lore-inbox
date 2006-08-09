Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWHIPth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWHIPth (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWHIPtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:49:36 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:31426 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751053AbWHIPte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:49:34 -0400
Date: Wed, 9 Aug 2006 11:49:09 -0400
Message-Id: <200608091549.k79Fn9Ht020260@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Jesse Barnes <jesse.barnes@intel.com>, Chris Wedgwood <cw@f00f.org>,
       jsipek@cs.sunysb.edu, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime 
In-reply-to: Your message of "Wed, 09 Aug 2006 07:03:49 PDT."
             <20060809140349.GE13474@goober> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, there may be another atime mode to consider, which I believe is what
Windows XP does w/ NTFS: only update the atime if it's newer than the
on-disk file's atime by N seconds (defaults to one hour, but I believe it's
configurable).  There could be scenarios in which this mode is preferable.

Erez.

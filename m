Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbUKQDRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUKQDRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUKQDPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:15:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:35016 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262188AbUKQDPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:15:24 -0500
Subject: Re: [2.6-BK-URL] NTFS 2.1.22 - Bug and race fixes and improved
	error handling.
From: Lee Revell <rlrevell@joe-job.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <E1CRsk5-0006JQ-KD@imp.csi.cam.ac.uk>
References: <E1CRsk5-0006JQ-KD@imp.csi.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 17:37:35 -0500
Message-Id: <1100644656.17573.0.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 13:42 +0000, Anton Altaparmakov wrote:
> Hi Linus, Hi Andrew, please do a
> 
> 	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6
> 

New warning with 2.6.10-rc2-mm1:

  CC [M]  fs/ntfs/super.o
fs/ntfs/super.c: In function `__get_nr_free_mft_records':
fs/ntfs/super.c:2105: warning: initialization from incompatible pointer type

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVAEBNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVAEBNt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVAEBNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:13:45 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63109 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262224AbVAEBMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:12:53 -0500
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: Nicholas Miell <nmiell@comcast.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, sfrench@samba.org,
       ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       samba-technical@lists.samba.org, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1104886081.3815.102.camel@localhost.localdomain>
References: <41D9C635.1090703@zytor.com>
	 <1104834865.26349.32.camel@imp.csi.cam.ac.uk>
	 <1104877121.3815.36.camel@localhost.localdomain>
	 <Pine.LNX.4.60.0501042251420.15144@hermes-1.csi.cam.ac.uk>
	 <1104886081.3815.102.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 17:12:50 -0800
Message-Id: <1104887570.3815.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 16:48 -0800, Nicholas Miell wrote:

> [ Note to audience: the following is a long (and largely irrelevant to
> the subject) discussion of how NTFS could implement reparse points and
> encryption on Linux. Feel free to ignore it. ]

Sorry for the reply to my own message, but I forget to mention in the
original that the right thing to do for the Encrypted and Reparse bits
may be just be to silently discard them and not support the manipulation
of these rather esoteric NTFS features through a general API at all.

-- 
Nicholas Miell <nmiell@comcast.net>


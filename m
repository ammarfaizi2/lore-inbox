Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270386AbRHMSqo>; Mon, 13 Aug 2001 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270387AbRHMSqf>; Mon, 13 Aug 2001 14:46:35 -0400
Received: from chinook.Stanford.EDU ([171.64.93.186]:35456 "EHLO
	chinook.stanford.edu") by vger.kernel.org with ESMTP
	id <S270386AbRHMSqY>; Mon, 13 Aug 2001 14:46:24 -0400
Date: Mon, 13 Aug 2001 11:46:36 -0700
To: linux-kernel@vger.kernel.org
Subject: 2.4.9-pre1 NFS problem
Message-ID: <20010813114636.A4641@chinook.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Mailer: Mutt http://www.mutt.org/
From: Max Kamenetsky <maxk@chinook.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like 2.4.9-pre1 breaks the NFS server.  Directories still get
exported and clients can mount them fine, but the ls command on the
client fails to report any files.  Filename completion also doesn't
work.  However, files can still be viewed if you know the exact file
name.

The same problem happens with 2.4.9-pre2.

Max

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbTCQOkC>; Mon, 17 Mar 2003 09:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbTCQOkC>; Mon, 17 Mar 2003 09:40:02 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:29313 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S261697AbTCQOkB>; Mon, 17 Mar 2003 09:40:01 -0500
From: jlnance@unity.ncsu.edu
Date: Mon, 17 Mar 2003 09:50:54 -0500
To: linux-kernel@vger.kernel.org
Subject: NFS file consistency
Message-ID: <20030317145054.GA7030@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I am trying to track down some file consistency problems I am seeing
and I want to make sure my assumptions about NFS are correct.
    Say I have 2 NFS clients, machine A and machine B.  Machine A does
an open/write/close on a file.  After this machine B does an open/read on
the file.  Is machine B guaranteed to read the same data that A wrote
or is there a delay between the time A closes the file and the time B
can expect to see valid data?  Also if the file already existed before
A wrote it, and B had already read from it and closed it, does this
affect anything?

Thanks,

Jim

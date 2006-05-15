Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWEOPgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWEOPgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWEOPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:36:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:43322 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWEOPgy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:36:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dAnLOEJyx/Ahv6yAD2AwpqxWcqW3hq6eQ77N7M0LzR99DlBkAz+yBsysYtlKnpotfrrFhMhYRX6HxG5/ZLnJCRFNFDmypX6pm+FtmkmEGaX7lh8A7RU/ALUxiHs6dhHfr5VbFeZNV6HMYX6dqbhSLeYJGMcRJICkDmRpx0J+NCI=
Message-ID: <4ae3c140605150836i3f8d3890pa8568bf7d0431a7b@mail.gmail.com>
Date: Mon, 15 May 2006 11:36:53 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: NFS readdir problem
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use NFS to read a remote directory, which contains 56 entries. But
after the read, "ls -al" only show 26, 31, or 51 entries in three test
runs.

I have read the NFS  code "encode_entry" and related "nfs_readdir",
"nfs3_proc_readdir"..., but haven't find the right place that can
cause this problem.

Is there anyone has similar experience? Please help!

Thanks,
-x

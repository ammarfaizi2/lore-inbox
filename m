Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWCGFWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCGFWg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCGFWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:22:36 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:37879 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbWCGFWf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:22:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nFlSf/EuSqTeXgudT6s2TZ0jf9NHc32b/30Bz1MDwJ73Nd9N7gD5cWRnBt145uOJLrgpg1ZfRIquheulB7pKqF/KZPa7HlMARzYiBjf1gU54WZNk6fiM8oCGTasOlL3NpBI6mtrkyCA2VrbKxrD3eplNoqZEvXpEmG/BfZJXRVU=
Message-ID: <1458d9610603062122x4d5687efw99fca51944c56202@mail.gmail.com>
Date: Tue, 7 Mar 2006 13:22:34 +0800
From: "Sumit Narayan" <talk2sumit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Error while copying file on a new filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am involved in development of a new file system. I can successfully
write/read on the filesystem partition. But when I copy or move a
file, I get this error:

[root@sumit /mnt/newfs]# mv /root/1 .
mv: writing `/mnt/newfs/1': No space left on device

And although I get this error, the file is successfully copied to the
directory and I can read the file properly after that.

Can somebody please explain why this is happening. 'df' shows that
there are free available inodes/disk space. I am using device
virtualization to provide a single mount point for multiple devices.

Please let me know if you may require any further investigation logs.

thanks in advance,

with best regards,
Sumit

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVECVE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVECVE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVECVE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:04:57 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:60438 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261704AbVECVEx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:04:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kS7kzXbzLYNji86Y9W/82PT/uRt9EtW1+RNPhWliUuOFrHIRB1vgtzPnZO7ac9zT4HpkJ+IE2ZpAVLmnocrGt/+uZC7f5tEXBQH9Roz6d80A7RzMOPeUg1yLyTq7TA31OqHiH/p4R3sq99s3LdEBwxx7VaV6LKP2KB6nHyh2tRU=
Message-ID: <4ae3c1405050313585b1921ba@mail.gmail.com>
Date: Tue, 3 May 2005 16:58:13 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about Ext2/3 append-only attributes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read some specification says that if append-only is set to a
directory, you can only create or modify files in that directory, but
no delete.

But when I tried this attribute on a directory,  I was not able to
create new files in that directory.  let's say the derectory is /dev, 
I set it to be append-only with:

chattr +a /dev.

Then I cannot create new files in it with command cp /dev/aa /dev/bb,
not that aa is a normal text file here.

Why the result conflict with the specification? Is there anyway to
make a directory really append-only? Thanks in advance!

-x

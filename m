Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbUJ0OSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbUJ0OSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbUJ0OSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:18:38 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:14174 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262452AbUJ0OSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:18:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=L/+1otPjVc2yN1lzV/u0iJ4SBOzJVQCwbow2CS/Zvf1s4bBFxsxXfn0emLuogH2myAmzzlcuHZgd4qnStCd4rYOERnb7An4maDa25YBs8S1IrHXYgjgtegToXN3s3FOzCIvs1l8YvbzU5ZyPblFnrfJQtR89Iji3z8PranildQA=
Message-ID: <6cb735e904102707181e58d208@mail.gmail.com>
Date: Wed, 27 Oct 2004 17:18:31 +0300
From: Guven Demir <guven.demir@gmail.com>
Reply-To: Guven Demir <guven.demir@gmail.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Question: how to invalidate read cache
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i hope this is the right place to ask question... anyway, it goes like this:

how can i invalidate the read cache for a file system?

the reason i'm asking this question is:

i'm mounting this ntfs partition to my linux box r/o, which i also
used by "another os" running under vmware r/w.

so when this partition gets updated under vmware, linux does not get
the changes until i umount / mount the partition again.

the problem is, i cant do this when the partiton is busy so i'm stuck
with invalid directory entries etc...

so, is there a way to disable or invalidate the read cache for this partition?

thanks in advance.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWHCGPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWHCGPE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHCGPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:15:04 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:38980 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932355AbWHCGPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:15:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ol/yjvTc29uuovObN99uG5QocO7Qb3BVrsa4KHwvUOyN9nUW28cbcw5q3jpdzvPZb1H5Q3xvopB0JIpeaFNgs5eU2EuwMtGt0cqB43nx2qNw9EKMBdvXplovpbVL9s0/C5hYXSSv/kFSe/Ql5K9ZcbPeUtnIfBxNn02QICKMc2w=
Message-ID: <4ae3c140608022315y675eed20hcefbb8fb0407f4a3@mail.gmail.com>
Date: Thu, 3 Aug 2006 02:15:01 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Can someone explain under what condition inode cache pages can be swapped out?
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Specifically, how a swaping system determine which page should be
swapped out when memory is tight? Intuitively, I think inode cache
pages should be swapped out as late as possible. But how Linux mkae
decision on this? Why linux does not pin inode pages in the memory?

Thanks in advance for kind help!

xin

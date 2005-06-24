Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263124AbVFXJw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbVFXJw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 05:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbVFXJw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 05:52:58 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:57982 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263124AbVFXJw4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 05:52:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CJCnmkOjBzb3k+8Ss1A7UOjQG38kgy4IYpQQsG5QY//wt2lOhWTCS7WUYwlJQjgx20hYvNH/wf/HixvVuzHFqjbGCDrutfzIKPPkfn+mClVWxh7w/E+XiSlpir3Hosb45Bg3Zjb/hHNmmrFvNhQMKYVlAfthk2Murh2/D/DzRIM=
Message-ID: <a7a22cea05062402527387049@mail.gmail.com>
Date: Fri, 24 Jun 2005 02:52:55 -0700
From: kay kay <mkkcbe@gmail.com>
Reply-To: kay kay <mkkcbe@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: (memory mgmt) how to identify modified page
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a newbie when it comes to Linux kernel and sorry if my message is
not clear. I was wondering is there anyway that a user process can see
its list of (memory) pages that has been modified (since the last
checkpoint of the process). This is with respect to checkpoint-restart
Fault tolerance.  I want a process to write all modified pages to a
persistant file periodically (say local disk) just-in-case the process
crashed due to system failure.

Please cc me in your reply (mkkcbe@gmail.com).
-- 
Thanks,
-Kay.

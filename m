Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVHFN0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVHFN0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 09:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVHFN0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 09:26:19 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:12705 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261919AbVHFN0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 09:26:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=4WyOZr9YFZg4lZez5As5RkHYpWry04GTwomz4R54BN/V0+rG5kQqx6bkU/CBZuBFG6G0CvS0XH7vxVstKr6wq/sITDWnwEbMXH44sgLqW78+pmydzYG3tvIs8MPsV/lncNYIMliUWG5q5CdHcqN5Ob3yXcwh8ChTcEhhGWnIVWI=  ;
Subject: Freeing a dynamic struct cdev
From: "James C. Georgas" <jgeorgas@rogers.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 06 Aug 2005 09:26:15 -0400
Message-Id: <1123334776.29913.3.camel@Tachyon.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I allocate a struct cdev using cdev_alloc(), what function do I call
to free it when I'm done with it?

-- 
James C. Georgas <jgeorgas@rogers.com>


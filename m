Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWIZIwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWIZIwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 04:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWIZIwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 04:52:30 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:5226 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750730AbWIZIwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 04:52:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X6rPNNIsqf5mgiWenzc8VCj5n5u4R1D0Kc9UYman4ShYyA5uJDJ/j6t5ppVpwGfmuKPxgUPSYt+q5LF06Y4vmPpIxDCpPhNOtUv/WF7LYufUk51iwtdKCOsDYUa1YCVZ1L5xeqJxS3POOjJQ1o1cVfDbhhC239m1OnCw9As/h/U=
Message-ID: <24c1515f0609260152j256e8473yf2e4d14e65222c67@mail.gmail.com>
Date: Tue, 26 Sep 2006 11:52:29 +0300
From: "Janne Karhunen" <janne.karhunen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel threads and signals
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a kernel module foo that uses kernel thread bar. With
signal_pending() I can easily check whether or not thread has
pending signals, but what's the correct way to check for the
specific signal number(s)?


-- 
// Janne

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVDOEly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVDOEly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 00:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDOEly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 00:41:54 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:30082 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261430AbVDOElw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 00:41:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iEx2Iwc5e0eKBDlzsfxXxu3oTlxl6ytRDSPDKGb5R+oh4GEj8iPAlg2j0Fwfi+Coz0EDIjSX+897VNvTBov+Xb9TBqZXQySxe+RSke8sraRSTDf8XXgFNNE1bnNfuGsbbhWOF4tiMuS2j2qiZp0SbhUbuZ6gQvefXVk7XPtPZk8=
Message-ID: <17d7988050414214163b09759@mail.gmail.com>
Date: Fri, 15 Apr 2005 00:41:47 -0400
From: Allison <fireflyblue@gmail.com>
Reply-To: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: New kernel thread
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to create a new kernel thread that will stay alive as long as
the system is up. This should be created as soon as the system boots. 
I need this thread to perform a specific task.

I am not very familiar with the code. Where should I put this thread
creation and my function code (I mean which file ?)? Do I use
kernel_thread function to create a new thread ?

Do I need to cleanup when the system exists ? 
What function should I call ?

thanks,
Allison

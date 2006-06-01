Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWFAXje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWFAXje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWFAXje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:39:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:3535 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750975AbWFAXjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:39:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Dc/lG5YsgiPGKppSjKOZSxxgI18DwWNTwLI86viX6xGcOE648nN/D8dU37LJcmDSHKPBwIimuKiWQRxTG1TFaZTLNql2rw4d5fRjk6VDh/qekwt1+ad8WeNT6JGUO7GLXf1ySjl7xJZM8CwrcG9UZEOV9KKGAMa2srGqmcJW85E=
Message-ID: <447F7AA0.8020301@gmail.com>
Date: Fri, 02 Jun 2006 07:39:12 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jonsmirl@gmail.com, dhazelton@enter.net, dlang@digitalinsight.com,
       santiago@mail.cz, airlied@gmail.com, pavel@ucw.cz,
       alan@lxorguk.ukuu.org.uk, mrmacman_g4@mac.com, abraham.manu@gmail.com,
       linuxcbon@yahoo.fr, helge.hafting@aitel.hist.no,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	<9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>	<Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>	<200606011603.57421.dhazelton@enter.net>	<9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>	<447F56A0.8030408@gmail.com> <20060601160045.1638473a.akpm@osdl.org>
In-Reply-To: <20060601160045.1638473a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Console writes are done with the console semaphore held. printk will also
>> just write to the log buffer and defer the actual console printing
>> for later, by the next or current process that will grab the semaphore.
> 
> Always by the current process which holds console_sem.  Leaving the printing
> for the next process would be unacceptably too late for printk.

I stand corrected. Thank you.

Tony

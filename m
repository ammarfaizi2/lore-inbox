Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVCJJLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVCJJLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVCJJLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:11:24 -0500
Received: from main.gmane.org ([80.91.229.2]:47852 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262478AbVCJJLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:11:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: Can I get 200M contiguous physical memory?
Date: Thu, 10 Mar 2005 09:43:18 +0100
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <d0p1ag$ngk$1@sea.gmane.org>
References: <c4b38ec4050310001061c62b9d@mail.gmail.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54b8f1eb.dip.t-dialin.net
User-Agent: slrn/0.9.8.1 (Debian)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Luo <abcd.bpmf@gmail.com> wrote:
> Now, I am writing a driver, which need 200M contiguous physical
> memory? can do? how to do it?

The ftape utils have a tool called swapout which tries to 'free'
large chunks of memory which then can be allocated by the ftape
module loaded subsequently.
I don't know if this approach does also work with *such* large
chunks like yours.


regards,
   Mario
-- 
I thought the only thing the internet was good for was porn.  -- Futurama


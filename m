Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVIWMnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVIWMnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 08:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVIWMnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 08:43:17 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:51799 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750952AbVIWMnQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 08:43:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=e+j4fi+CJqvUDfxIEKEk7h3IAGH3iOuJ+RLOljo1EvwedhvINzgrKFUl1zbz6U7Ez7vtw4HeE0nXBZS7vHMlwunJsWbx/BJQcoCKBeGdSaoqiIqdtdtAa3g+bl4IQGdDX1qvgV22a94Nkc/3r2HcXojC8GPgzZngF5a+8J5WtAc=
Message-ID: <64c7635405092305433356bd17@mail.gmail.com>
Date: Fri, 23 Sep 2005 18:13:14 +0530
From: Block Device <blockdevice@gmail.com>
Reply-To: Block Device <blockdevice@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Trapping Block I/O
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I need to trap _all_ the I/O going to each and every block device
in the system. I used jprobes to trap calls to generic_make_request.
Is this the correct/only place to do such a thing ?
Or do I have to monitor the q->make_request_fn for every device ?

Thanks & Regards
-BD.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWFFVpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWFFVpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWFFVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:45:44 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:49685 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751166AbWFFVpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:45:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Vf6AT/kvczu3sX1ftDovI2CVXUfx8iFR6mbiLYpG20pIlp1E8eP1AdBAmwa/53jylWlBnOIsjfB3X1l0Gsp7gZycuL4jawRE2C/peEBHdJMm/xnargvR0z8Qw14RT9TX7QQLJx2wHMoQpk6sXMCbEykJrY+HYfRlZ6mKYpveYlY=
Message-ID: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
Date: Wed, 7 Jun 2006 03:15:43 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Quick close of all the open files.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found that the following code is closing all the open files by the
program, do you think its a bug in kernel code?

------------
fp = tmpfile();
fp->_chain = stderr;
fpclose(fp);
fp = NULL;
------------

o Is there any other elegant way to close all the open files (rather
than reading from /proc/<pid>/fd and calling close on each of the fd?)

Looking forward to hear from you.

Thank you,
Vamsi.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWCVNvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWCVNvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCVNvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:51:00 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:50457 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751240AbWCVNvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:51:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NY3AJ/9EMZsXiuiAfGUq6XkZpLMIeUGYN+SCHsmgRLOU3qMPtGPa71iffiUxfwGbroO3Fs5SJQdzJObJTMbxOFK0zmOaRx62NdEWQGAirA41DQ6wOAY893iO55sPON/iuZrp7Pp+LXiKM6bCXAs/v3FI8yj1mE83SsGf0capyUY=
Message-ID: <b681c62b0603220550w1c94a3c1jefcc15d252d1751f@mail.gmail.com>
Date: Wed, 22 Mar 2006 19:20:58 +0530
From: "yogeshwar sonawane" <yogyas@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: writing to a device through driver entrypoint or directly from user space after mapping it
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

If I want to write to a register of a PCI device which is in BAR
region, there are two ways:-
1) inside write() entrypoint of my driver, i can write to that
particular register.
2) if i have mapped my BAR region to user space, then writing to the
required register directly from user space.

So is there any difference in performance or time required to write to
a device from write() entrypoint of a driver or mapping a BAR region
to user space & then writing to it from user space?

are there any advantages / disadvantages ?

If i am wrong, correct me please.
Thanks in advance.

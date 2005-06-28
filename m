Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVF1R66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVF1R66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVF1R66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:58:58 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:54580 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262127AbVF1R6z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:58:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AvHodJXIveukyUM6tgek01azDMAhFHdvXd1dgMbwqPh6dZSlD2MmCKhuaGqRHc0CbnVWrbmpKvTKSiQphHt3p68PjrJ9LuNUU61fn4zNXVhDAUSjt0R7v5mM+BB9/2OLRcPDHxI7y+GPvWXjL3ceSM6extR47ZDRg68zIG+ldGM=
Message-ID: <94e67edf05062810586d6141f3@mail.gmail.com>
Date: Tue, 28 Jun 2005 13:58:54 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Memory management while loading program in Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a query regarding memory management using Linux kernel.

In our system we have a secure physical memory starting and ending at
predefined addresses. We want to execute certain programs, which have
to be running secure in those address spaces only.

Is it possible to force the loader to load the "particular" program
(both the code and data segment) at that pre-defined secure physical
memory, without any major kernel changes?

Thanks,

Sreeni

(sreeni@nec-labs.com)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWFSAn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWFSAn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWFSAn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:43:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:5959 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751128AbWFSAnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:43:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=Y5AQ/C8ukaj1kNJN3D3aSNJIJkXnKCNkCcO4eCXFjxwuRtlKh5Rgi1+H9NyWlQKWq1xoQ7qkt72PWOhneZ6N1GfvEd9IJxRdFoI2TpwReELYJKlb4ksr45EgCpc2Q3Uc0DRmcur6ehTNlR0tJoXsWhPIgS6EmLvnludMs62qL6A=
Message-ID: <4495F344.8080705@gmail.com>
Date: Mon, 19 Jun 2006 02:43:48 +0200
From: Wojciech Moczulski <wmoczulski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suspending and resuming a single task
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm doing some research on suspending/resuming a single task in Linux 2.6.x.
At this point I've succeded dumping the whole task state (CPU context, regs,
memory, fds, etc.) to an external file and reading it back to a pre-defined
structure (I know that reading/writing files directly to/from kernel is a bad
thing - I'm working *only* on a p.o.c. and currently there's no other
purpose), but I'm stuck in getting restored task to get running again.

Are there any ways to re-register restored task as a running one in some
"easy" way or should I perform some manual modyfications to the kerenel
structures?

Can anyone suggest me some solution to this problem?

Regards,
Wojciech

PS. I'm not on a list so please CC me, please.

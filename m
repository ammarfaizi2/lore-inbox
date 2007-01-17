Return-Path: <linux-kernel-owner+w=401wt.eu-S1750969AbXAQMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbXAQMMt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 07:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXAQMMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 07:12:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:47364 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbXAQMMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 07:12:48 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gY8iGhrICeEfxW3vN2RBXUnB1zkmsk/fcvKEpAiNPLAK8zxmGjgNVkU8e6dqQ6C4aDAtTupQS+GwQ4eRoYNprNkuQvI21dUn0oFnskII/Fl+UsSaRMDbIowdKFjDlKTnPwGS4DlMPjDkCFFBsT/bjzPzZ8MOgfsPm/2YY6Xhbnc=
Message-ID: <7783925d0701170412u2db661d6md5890f2a713ee808@mail.gmail.com>
Date: Wed, 17 Jan 2007 17:42:46 +0530
From: "Rick Brown" <rick.brown.3@gmail.com>
To: kernelnewbies@nl.linux.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL not mandatory in 2.4.x?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1) I'm using two 2.4 based kernel modules. The first module defines a
symbol but does not EXPORT_SYSMBOL() it. Would my second module be
able to use that symbol? In 2.4? In 2.6?

2) Also, in 2.4, is it OK if I start using my device memory before
request_mem_region()?

Thanks,

Rick

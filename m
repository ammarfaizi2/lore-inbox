Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVHCQVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVHCQVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVHCQVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:21:12 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:10884 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262325AbVHCQVI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:21:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hxH/NrP01LV3MyqxLxxEAIEjOZunkbfEnjvgp/YhWQBjwPIggPmATtAaKZ9ZKPSUuHtkVbqBHDZOvA0WqgGuttwwq9KsyGIfyCd+EoAJtY22CoGn/yJDii6ljo8jSEA/q/MNigySDWYvA++lHmkxF88vJki9aRPLnelUuxX1Hzk=
Message-ID: <3faf05680508030921277d78a9@mail.gmail.com>
Date: Wed, 3 Aug 2005 21:51:04 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Forcing kernel to avoid vDSO mapping.
Cc: roland@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Sorry to interrupt you.

There seem to be some architecture specific problems using ptrace in
the vDSO segment on IA32, ptrace and read fails from this segment with
BAD ADDRESS.

I was just wondering if there could be any why we can tell kernel not
to map this vDSO for optimization of system call overhead.

Your kind help and effort regarding this issue is greatly appreciated.

Thanks a lot.

Regards,
Vamsi kundeti

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUATTiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbUATTiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:38:00 -0500
Received: from main.gmane.org ([80.91.224.249]:64208 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265695AbUATThw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:37:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: HPT370 status [2.4/2.6]
Date: Tue, 20 Jan 2004 20:37:50 +0100
Message-ID: <yw1x4quqo1gx.fsf@ford.guide>
References: <1g0ZG-2q6-15@gated-at.bofh.it> <400D72B5.40705@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:WJ021o1U7zn7hFdU3SQtTG2A+i0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:

> Jan De Luyck wrote:
>> Hello List,
>> Before I start frying my disks and all, what's the usability status
>> of the Hightpoint HPT370 ide "raid" controller on linux 2.4 and 2.6?
>
> 2.4 is fine if you use the ataraid code. mirroring is not fault
> tolerant so you would not want to use that.

Isn't fault tolerance the purpose of mirroring?

> raid-0 and jbod is ok. i am currently looking into 2.6. i will
> probably write an evms plugin for the new kernel. the nice thing is
> that it will work also for 2.4er kernels with the evms patches plus
> we get a proper mirroring solution for free. :)

The Linux md driver already does many different raid variants,
including mirroring.

-- 
Måns Rullgård
mru@kth.se


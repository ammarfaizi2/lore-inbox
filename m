Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSHUSA6>; Wed, 21 Aug 2002 14:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318562AbSHUSA6>; Wed, 21 Aug 2002 14:00:58 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:29458
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318560AbSHUSA5>; Wed, 21 Aug 2002 14:00:57 -0400
Subject: Re: Overcommit_memory logic fails when swap is off
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: josip@icase.edu, linux-kernel@vger.kernel.org
In-Reply-To: <1029950619.26845.106.camel@irongate.swansea.linux.org.uk>
References: <3D63C9DE.7479D2E9@icase.edu> 
	<1029950619.26845.106.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Aug 2002 14:04:33 -0400
Message-Id: <1029953073.1935.826.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 13:23, Alan Cox wrote:

> 2.5 propses including the ability to set the %age between the 0% of mode
> 3, the 50 of mode 2 and upwards to things relevant in some embedded
> system cases. So for 2.6 you will be able to tune it in different ways
> according to precise understanding of workload.

Alan, hch or someone asked if it would be possible to merge the 2.5
behavior into 2.4-ac ... are you interested or do you not want to break
compatibility?

Note for "mode 2" the behavior is identical.  For "mode 3" they would
also need to set vm_memory_ratio to "0".

If you are willing, I'll send you a diff...

	Robert Love


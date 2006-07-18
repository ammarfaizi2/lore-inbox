Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWGRMvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWGRMvv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWGRMvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:51:51 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:33592 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932186AbWGRMvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:51:50 -0400
Subject: Re: [patch 5/6] s390: .align 4096 statements in head.S
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
In-Reply-To: <Pine.LNX.4.61.0607180825240.11870@chaos.analogic.com>
References: <20060718115622.GE20884@skybase>
	 <Pine.LNX.4.61.0607180825240.11870@chaos.analogic.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 18 Jul 2006 14:51:44 +0200
Message-Id: <1153227104.9681.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 08:43 -0400, linux-os (Dick Johnson) wrote:
> Hardcoading like that can cause hard to find errors. It looks like
> you wrote something in 'C' and tried to use its assembly code. You
> should know that you don't need ".fill" if you have correctly
> allocated
> data.

Huh ?!? We are talking about head.S here. That is pure assembler, no C
anywhere. It is the startup code of the kernel, and we do want to
control where things end up.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



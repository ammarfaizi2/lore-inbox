Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262741AbREVTdt>; Tue, 22 May 2001 15:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbREVTdj>; Tue, 22 May 2001 15:33:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:58013 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262741AbREVTd1>;
	Tue, 22 May 2001 15:33:27 -0400
Date: Tue, 22 May 2001 21:33:23 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105221933.VAA78546.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] s_maxbytes handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus writes:

	0 is EOF _for_reads_. For writes it is not very well defined

Hmm.

	So -EFBIG is certainly the preferable return value,

Yes. The Austin 6th draft writes

EFBIG:
An attempt was made to write a file that exceeds the implementation-defined
maximum file size  or the process' file size limit, and there was no room for 
any bytes to be written.

Andries

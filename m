Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbREPWh2>; Wed, 16 May 2001 18:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262115AbREPWhT>; Wed, 16 May 2001 18:37:19 -0400
Received: from kosh.narus.com ([64.240.193.204]:56338 "EHLO kosh.narus.com")
	by vger.kernel.org with ESMTP id <S262113AbREPWhD>;
	Wed, 16 May 2001 18:37:03 -0400
Message-ID: <580E532D9F7A9B4BAE8A130848E0DDA70B7842@franklin.narus.com>
From: Scott Huang <SHuang@narus.com>
To: linux-kernel@vger.kernel.org
Subject: CMPXCHG
Date: Wed, 16 May 2001 15:37:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-15"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Four adapters need to produce data to a 
descriptor queue which is consumed by a
user process. A lock mechanism was implemented
to sync the adapters. However, this causes 
a performance hit.  Is it possible to use
CMPXCHG on Intel's i-386 to avoid the locking?
Where can I find some doc and some sample code?

Thx

-Scott

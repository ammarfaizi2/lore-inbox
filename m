Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWFAL5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWFAL5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWFAL5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:57:18 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:57534 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030186AbWFAL5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:57:17 -0400
Message-ID: <447ED570.5020303@aitel.hist.no>
Date: Thu, 01 Jun 2006 13:54:24 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2 stack unwind compile failure
References: <20060601014806.e86b3cc0.akpm@osdl.org>
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rc5-mm2 with the cfq hotfix:

  CC      kernel/unwind.o
kernel/unwind.c: In function ‘unwind_add_table’:
kernel/unwind.c:189: error: dereferencing pointer to incomplete type
kernel/unwind.c:190: error: dereferencing pointer to incomplete type
kernel/unwind.c:190: error: dereferencing pointer to incomplete type
kernel/unwind.c:191: error: dereferencing pointer to incomplete type
kernel/unwind.c:191: error: dereferencing pointer to incomplete type
make[1]: *** [kernel/unwind.o] Error 1
make: *** [kernel] Error 2


Now recompiling without "stack unwind support"

Helge Hafting

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271650AbRHQPJR>; Fri, 17 Aug 2001 11:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271668AbRHQPJH>; Fri, 17 Aug 2001 11:09:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271650AbRHQPI5>; Fri, 17 Aug 2001 11:08:57 -0400
Subject: Re: Kernel panic problem in 2.4.7
To: antihong@tt.co.kr (=?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?=)
Date: Fri, 17 Aug 2001 16:11:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "=?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?=" at Aug 17, 2001 11:36:35 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XlHk-0007Uy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If your cpu context corrupt is with a machine check exception report then
your processor took an internal fault reporting trap. So its not a happy
bit of silicon I suspect - be it overclocked, overheated, or even faulty.

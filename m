Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132253AbRCVXej>; Thu, 22 Mar 2001 18:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132248AbRCVXea>; Thu, 22 Mar 2001 18:34:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37898 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132251AbRCVXeT>; Thu, 22 Mar 2001 18:34:19 -0500
Subject: Re: Linux 2.4.2-ac21
To: ksi@cyberbills.com (Sergey Kubushin)
Date: Thu, 22 Mar 2001 23:36:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31ksi3.0103221518020.22784-100000@nomad.cyberbills.com> from "Sergey Kubushin" at Mar 22, 2001 03:25:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gEd7-0003Yk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 22 Mar 2001, Alan Cox wrote:
> 
> Does not build for PPro/P-II. i586 is OK.

You need to avoid enabling 64G support. The PAE stuff (as Linus said with
2.4.3pre6) is currently broken. Once Linus and co fix it I'll merge the fixed
one

Alan


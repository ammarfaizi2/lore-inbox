Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbREPMTE>; Wed, 16 May 2001 08:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbREPMSy>; Wed, 16 May 2001 08:18:54 -0400
Received: from femail18.sdc1.sfba.home.com ([24.0.95.145]:18077 "EHLO
	femail18.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S261898AbREPMSk>; Wed, 16 May 2001 08:18:40 -0400
Message-ID: <3B026E5F.58059EBB@didntduck.org>
Date: Wed, 16 May 2001 08:11:11 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-bg1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jalajadevi Ganapathy <JGanapathy@storage.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel2.2 to kernel2.4!!
In-Reply-To: <OF8E6F662B.FFAB9815-ON85256A4E.00424ECA@storage.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jalajadevi Ganapathy wrote:
> 
> Hi , I encounter an unresolved symbol __bad_udelay when i ported a network
> driver from kernel2.2 to 2.4.
> Could anyone plz tell me what is the corresponding fxn in 2.4??
> 
> Thanks
> Jalaja

You used too large of a value for udelay().  Switch to using mdelay()

-- 

						Brian Gerst

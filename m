Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRHFMOP>; Mon, 6 Aug 2001 08:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268053AbRHFMOF>; Mon, 6 Aug 2001 08:14:05 -0400
Received: from t2.redhat.com ([199.183.24.243]:36087 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S268071AbRHFMNz>; Mon, 6 Aug 2001 08:13:55 -0400
Message-ID: <3B6E8A09.ABCDAFFC@redhat.com>
Date: Mon, 06 Aug 2001 13:14:02 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-3.1smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ReiserFS file corruption
In-Reply-To: <3B6E84A1.1A13969@crm.mot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Varagnat wrote:
> 
> Today, I crashed the kernel and after reboot the source file
> I was working on, was completly unreadable. The size indicated
> by 'ls' seems to be good but with bad data.

Well reiserfs doesn't guarantee the CONTENTS of the file to be 
consistent after a crash; only the metadata.

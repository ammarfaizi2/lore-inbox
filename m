Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292530AbSBZAEh>; Mon, 25 Feb 2002 19:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292527AbSBZAE2>; Mon, 25 Feb 2002 19:04:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62220 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292533AbSBZAEP>;
	Mon, 25 Feb 2002 19:04:15 -0500
Message-ID: <3C7AD0AC.13A554DA@zip.com.au>
Date: Mon, 25 Feb 2002 16:02:52 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/resume and 3c59x
In-Reply-To: <20020225200056.GW12719@ufies.org> <3C7A9C75.F6A4BA05@zip.com.au>,
		<3C7A9C75.F6A4BA05@zip.com.au> <20020225233242.GA5370@ufies.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:
> 
> Thank Andrew.
> My problem is solved with 2.4.18 and 'options 3c59x enable_wol=1'.
> 

Right, thanks.

Just for the record: Both Christophe's 3c<mumble> and my 3c556B
mini-PCI NIC failed to survive APM resumes in 2.4.17.  But something
outside the 3c59x driver got fixed somewhere in the 2.4.18-pre series,
and resume works OK in 2.4.18.

-

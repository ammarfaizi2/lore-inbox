Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278642AbRKAKBN>; Thu, 1 Nov 2001 05:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278639AbRKAKBD>; Thu, 1 Nov 2001 05:01:03 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:40208 "HELO due.stud.ntnu.no")
	by vger.kernel.org with SMTP id <S278647AbRKAKAw>;
	Thu, 1 Nov 2001 05:00:52 -0500
Date: Thu, 1 Nov 2001 11:00:02 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org, J Sloan <jjs@pobox.com>
Subject: Re: Intel EEPro 100 with kernel drivers
Message-ID: <20011101110002.A22504@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011029021339.B23985@stud.ntnu.no> <3BDCD06E.8AF8FF69@pobox.com> <20011031090125.B10751@stud.ntnu.no> <20011031182212.A21776@castle.nmd.msu.ru> <20011101085523.D2102@stud.ntnu.no> <20011101124751.B26220@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011101124751.B26220@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Thu, Nov 01, 2001 at 12:47:51PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin:
> >From the computer where the network card hangs and where you see messages in
> dmesg.  The network card hangs on only one side, right?

Yepp, and sorry, I ment, I tried pinging from client-side.

> If the operations stall just for few seconds, it's perfectly ok.
> If after a few second stop the card itself resumes to operate normally, but
> NFS operations are blocked for much longer time, it's NFS problem.
> If the card itself stops operation for a long time, it needs to be fixed.

Ok, it seems like the stock-kernel-driver hangs much longer than the
intel-driver (intel driver did only hang for a few sec when I tried just
now).

-- 
Thomas

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283422AbRK2Wdu>; Thu, 29 Nov 2001 17:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283421AbRK2Wdk>; Thu, 29 Nov 2001 17:33:40 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:12510 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S283422AbRK2Wd0> convert rfc822-to-8bit; Thu, 29 Nov 2001 17:33:26 -0500
Date: Thu, 29 Nov 2001 20:40:06 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <matthias@winterdrache.de>, <linux-kernel@vger.kernel.org>
Subject: Re: sym53c875: reading /proc causes SCSI parity error
In-Reply-To: <20011128.144925.94842859.davem@redhat.com>
Message-ID: <20011129203311.F2019-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Nov 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Wed, 28 Nov 2001 20:51:01 +0100 (CET)
>
>    On Wed, 28 Nov 2001, David S. Miller wrote:
>
>    > Why not just put some bitmap pointer into the pci device
>    > struct.  If it is non-NULL, it specifies PCI config space
>    > areas which have side-effects.
>
>    Or a simple offset beyond which reading data isn't desirable for
>    whatever reasons.
>
> I do not think that is sufficient.
>
> I have seen chips where only one single PCI config space word would
> trigger problems, and it was due to a hw bug.  The "offset beyond"
> scheme would not allow to cover this case.

OK. I ignored that such weirdness existed.

  Gérard.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRK1Won>; Wed, 28 Nov 2001 17:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281770AbRK1Wod>; Wed, 28 Nov 2001 17:44:33 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:60644 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S280938AbRK1WoR> convert rfc822-to-8bit; Wed, 28 Nov 2001 17:44:17 -0500
Date: Wed, 28 Nov 2001 20:51:01 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <matthias@winterdrache.de>, <linux-kernel@vger.kernel.org>
Subject: Re: sym53c875: reading /proc causes SCSI parity error
In-Reply-To: <20011128.131503.22504634.davem@redhat.com>
Message-ID: <20011128203718.L2777-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Nov 2001, David S. Miller wrote:

>    From: Gérard Roudier <groudier@free.fr>
>    Date: Wed, 28 Nov 2001 19:14:52 +0100 (CET)
>
>    This is a known issue that had been discussed in time, but no fix had been
>    considered worth to be applied by PCI et co maintainers.
>
> Why not just put some bitmap pointer into the pci device
> struct.  If it is non-NULL, it specifies PCI config space
> areas which have side-effects.

Or a simple offset beyond which reading data isn't desirable for whatever
reasons.

  Gérard.


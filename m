Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbSLPSrm>; Mon, 16 Dec 2002 13:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267052AbSLPSrm>; Mon, 16 Dec 2002 13:47:42 -0500
Received: from ny2.fastmail.fm ([66.111.4.3]:60366 "EHLO server2.fastmail.fm")
	by vger.kernel.org with ESMTP id <S267049AbSLPSrS>;
	Mon, 16 Dec 2002 13:47:18 -0500
X-Mail-from: aravind1001@speedpost.net
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.71; T1.001; A1.51; B2.12; Q2.03)
From: "Aravind Ceyardass" <aravind1001@speedpost.net>
To: "arun4linux" <arun4linux@indiatimes.com>,
       "Michael Richardson" <mcr@sandelman.ottawa.on.ca>, netdev@oss.sgi.com,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Date: Mon, 16 Dec 2002 14:55:13 -0400
X-Epoch: 1040064913
X-Sasl-enc: K1tEy+9myIhjIDMkv6MRmQ
Cc: aravind1001@speedpost.net
Subject: Re: Re: pci-skeleton duplex check
References: <200212141428.TAA32351@WS0005.indiatimes.com>
In-Reply-To: <200212141428.TAA32351@WS0005.indiatimes.com>
Message-Id: <20021216185513.43F023D56F@server2.fastmail.fm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

A good scheme for numbering kernels or software components in general is
as follows

For stable releases. (x.even.y=major.minor.patch)

increment patch for any bug fixes.
increment minor for any enhancements or new interfaces.
increment major for interface changes or interface deletions.(dangerous
or poor design)

We should increment major even if interface remains same but behaviour
has changed.(again may be poor design)

For development releases we can't follow the above scheme, because the
interfaces are in a flux and we may end up
in version 589.201.700 from 2.4.20. So, we decide to increment patch
number for all changes and deletions.

Hope it helps!

Regards

Aravind


-- 
http://fastmail.fm - IMAP accessible web-mail

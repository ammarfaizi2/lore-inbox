Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbSKMUSq>; Wed, 13 Nov 2002 15:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSKMUSq>; Wed, 13 Nov 2002 15:18:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11930 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262631AbSKMUSp>;
	Wed, 13 Nov 2002 15:18:45 -0500
Message-ID: <3DD2B525.B0F1DC3@us.ibm.com>
Date: Wed, 13 Nov 2002 12:25:09 -0800
From: Nivedita Singhvi <nsnix@spiritone.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: folkert@vanheusden.com
CC: linux-kernel@vger.kernel.org
Subject: RE: tcp_v4_get_port?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Kernel 2.4.19
> Changes like; have it not starting to use ports from 1024 up, but
> rather from 32768 down to 1024 (and then from 65535 down again).

In 2.4.19, see tcp_v4_hash_connect() also, if youre autobinding
on a connect().

thanks,
Nivedita

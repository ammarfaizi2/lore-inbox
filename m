Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSIZA6y>; Wed, 25 Sep 2002 20:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSIZA6y>; Wed, 25 Sep 2002 20:58:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:25051 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261393AbSIZA6y>; Wed, 25 Sep 2002 20:58:54 -0400
Message-ID: <3D925E65.F0A4F45D@us.ibm.com>
Date: Wed, 25 Sep 2002 18:09:57 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <3D924F9D.C2DCF56A@us.ibm.com>
		<20020925.170336.77023245.davem@redhat.com>
		<3D9259C3.6CA5D211@us.ibm.com> <20020925.174019.21928114.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

>    Well, true - we have per hashchain locks, but are we now adding
>    the times we need to lookup something on this chain because we now
>    have additional info other than the route, is what I was
>    wondering..?
> 
> That's what I meant by "extending the lookup key", consider if we
> took "next protocol, src port, dst port" into account.

Aah!. thick head <-- understanding. 

thanks,
Nivedita

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSGWKN1>; Tue, 23 Jul 2002 06:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSGWKN1>; Tue, 23 Jul 2002 06:13:27 -0400
Received: from rzfoobar.is-asp.com ([217.11.194.155]:32920 "EHLO mail.isg.de")
	by vger.kernel.org with ESMTP id <S318017AbSGWKNY>;
	Tue, 23 Jul 2002 06:13:24 -0400
Message-ID: <3D3D2CFD.1AEEBE5D@isg.de>
Date: Tue, 23 Jul 2002 12:16:29 +0200
From: Peter Niemayer <niemayer@isg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: read/recv sometimes returns EAGAIN instead of EINTR on SMPmachines
References: <3D3BE1C2.CB89D124@isg.de> <20020722.195749.34129476.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

> Can you cite some part of the POSIX spec which states that EAGAIN
> cannot be returned when signals are received by a caller of
> tcp_recvmsg?

See: http://www.opengroup.org/onlinepubs/007904975/functions/recv.html

IMHO, the text is in no way unclear that EAGAIN is not the correct return
code for the situation while EINTR definitely is.

Regards,

Peter Niemayer

